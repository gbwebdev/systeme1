#import "@local/it-course:0.1.0" : *
#import "@preview/sourcerer:0.2.1": code

#show: chapter.with(
  subject: "Système 1",
  subject-subtitle: "Découverte de linux",
  topic: "Chapitre 5",
  subtitle: "Aller plus loin avec le shell",
  illustration: image("./couverture.png", width: 14cm),
  author: "Guillaume BITON",
  credit: "Droits d'exploitations accordés à l'ECE",
  licence: [Ce document est protégé par la licence CC BY-NC 4.0 https://creativecommons.org/licenses/by-nc/4.0/)],
  version: "1.0",
  lang: "fr",
  logo: image("../.assets/gbweb-ece.png", width: 9cm)
)

#heading(level: 1, numbering: none)[INTRODUCTION]

Dans ce chapitre, nous allons aborder plus en profondeur l'utilisation du shell.

#pagebreak()

= Syntaxe

== Quelques rappels

- Le premier mot que le shell attend que vous tapiez est une commande (sauf dans le cas de l’assignation d’une variable, mais nous y reviendrons plus tard).
- Après la commande viennent les options puis les arguments.
- Le caractère « espace » sert de séparateur.
- Les options commencent par un tiret "`-`" (dans le cas d’options raccourcies) ou deux tirets "`--`" (dans le cas d’options longues).
- Les options peuvent être des « flags » (leur simple présence est auto-suffisante) ou elles peuvent elles-mêmes attendre un argument.
- La plupart des commandes ont une option `--help` qui permet d'afficher une aide.
- La commande `man` permet de parcourir le manuel.

== Exemple

Voici un extrait de l'aide de la commande `tail` :

```console
$ tail --help
Utilisation : tail [OPTION]... [FICHIER]...
Afficher les 10 dernières lignes de chaque FICHIER sur la sortie standard.
Avec plusieurs FICHIERs, écrire un en-tête donnant le nom avant chaque fichier.

Sans FICHIER ou quand FICHIER est -, lire l'entrée standard.

Les arguments obligatoires pour les options longues le sont aussi pour les options courtes.
-f, --follow             afficher les données ajoutées au fur et à mesure
                             que le fichier grandit ; 
-n, --lines=[+]N         afficher les N dernières lignes, au lieu des 10
                             dernières, -n +N pour afficher à partir de
                             la Nième
```

D'après cette aide, je comprends que je peux me servir de cette commande de la manière suivante :

```console
$ tail –f fichier.txt
```
- On a utilisé le raccourci « `-f` » de l’option de type flag « `--follow` ». \
  Comme c’est un flag, il n’y a rien à rajouter.\ 
  Sa simple présence signifie pour tail « surveille le fichier : si du nouveau contenu est ajouté dedans, affiche-le ».
- On a passé comment argument « fichier.txt » : c’est le fichier dont on veut lire la fin.

```console
$ tail –f -n fichier.txt
tail: nombre de lignes incorrect: « fichier.txt »
```
Ici, on a passé l'option `-n`, raccourci de `--lines`, mais on n'a pas précisé l'argument de l'option ("N", dans le manuel), et shell ne comprend pas : notre commande est mal formattée.

#pagebreak()

Il faudrait pluôt écrire, par exemple :
```console
$ tail –f -n 50 fichier.txt
```
Dans ce cas, on demande à tail d'afficher les 50 dernières lignes du fichier, et de rester à l'écoute de nouvelles lignes qui appraitraient.


Il est possible de mettre les options raccourcies les unes à la suite des autres, en faisant attention à mettre les arguments aux bons emplacements.

Par exemple, à la place de `tail –f -n 50 fichier.txt`, on aurait pu écrire :
```console
$ tail –fn 50 fichier.txt
```

Mais si on avait écrit :
```console
$ tail –nf 50 fichier.txt
```
Cela n'aurait pas fonctionné : n doit être suivi du nombre de lignes.

--

Maintenant, considérons l'exemple suivant :
```console
$ tail fichier1.txt fichier2.txt
```
On a passé le nom de deux fichiers. Tail va donc afficher la fin de chaque fichier.

On n’est pas obligé de passer des options (elles portent donc bien leur nom).

*_Mais si je vaux afficher la fin d’un fichier dont le nom comporte des espaces ?_*

Si j'écris :
```console
$ tail fichier numero un.txt fichier2.txt
```
Alors tail croit que je lui demande d’afficher la fin de « fichier », de « numero », de « un.txt » et enfin de « fichier2.txt ».

Il faudrait que j'écrive :
```console
$ tail "fichier numero un.txt" fichier2.txt
```

On a utilisé des guillemets "`"`". Ce sont des *caractères de citation*.

#pagebreak()

== Caractères de citation

- Le plus souvent, on utilise les guillemets doubles (double-quotes). Ils servent à :
  - Regrouper des termes
  - En permettant l’interprétation des variables et des commandes
- On peut aussi utiliser les apostrophes (simple-quotes). Ils servent à :
  - Regrouper les termes
  - En NE permettant PAS l’interprétation des variables et des commandes
- Enfin, l’accent grave (back-tick) permet d’interpréter une commande.

=== Exemple :

```console
$ echo "Bonjour, $USER ! Nous sommes le `date`"
Bonjour, prof ! Nous sommes le dim. 26 jan. 2025 11:40:29 CET
$ echo 'Bonjour, $USER ! Nous sommes le `date`'
Bonjour, $USER ! Nous sommes le `date`
```

== Caractères génériques

- L’astérisque (« `*` ») est aussi appelé « joker » ou « wildcard ».
- Il veut dire « n’importe quelle suite de caractères ».
- Le point d’interrogation veut dire « n’importe quel caractère ».
- Les crochets permettent de signifier « n’importe quel charactère parmi ceux entre crochets »
- Les accolades sont étendues en listant chaque éléments séparés par des virgules à l’intérieur de l’accolade.

#info()[
  Quand on utilise des caractères génériques, la première chose que va faire le shell est de les remplacer par les éléments correspondants.\ 
  Ensuite, seulement, il exécutera la commande.
]


=== Exemples :

```console
$ ls
nouveau_fichier_1  nouveau_fichier_3  nouveau_fichier_5  titi
vieux_fichier_1    vieux_fichier_3    vieux_fichier_5    nouveau_fichier_2
nouveau_fichier_4  tata               toto               vieux_fichier_2
vieux_fichier_4
$ ls vieux_fichier_*
vieux_fichier_1  vieux_fichier_2  vieux_fichier_3  vieux_fichier_4  vieux_fichier_5
$ ls *_fichier_*
nouveau_fichier_1  nouveau_fichier_3  nouveau_fichier_5  vieux_fichier_2
vieux_fichier_4    nouveau_fichier_2  nouveau_fichier_4  vieux_fichier_1
vieux_fichier_3  vieux_fichier_5
$ ls t?t?
tata  titi  toto
$ ls t[ai]t[ai]
tata titi
```

#pagebreak()

```console
$ touch {lun,mar,mercre,jeu,vendre,same}di dimanche
$ ls
dimanche  jeudi  lundi  mardi  mercredi  samedi  vendredi
```

```console
$ mkdir -p semaine{1,2}/{{lun,mar,mercre,jeu,vendre,same}di,dimanche}
$ tree
├── semaine1
│   ├── dimanche
│   ├── jeudi
│   ├── lundi
│   ├── mardi
│   ├── mercredi
│   ├── samedi
│   └── vendredi
└── semaine2
    ├── dimanche
    ├── jeudi
│   ├── lundi
│   ├── mardi
│   ├── mercredi
│   ├── samedi
│   └── vendredi
```

```console
$ touch {lun,mar,mercre,jeu,vendre,same}di dimanche
$ ls
dimanche  jeudi  lundi  mardi  mercredi  samedi  vendredi
```


== Navigation au clavier & raccourcis

Quand on ecrit ses commandes dans le shell, on peut se servir des quatre touches du clavier :
- les flèches ◄ et ► pour déplacer le curseur à gauche et à droite dans la commande qu'on est en train de taper.
- la flèche ▲ pour remonter dans l'historique des commandes (remettre dans le prompt les commandes précédemment tapées).
- la flèche ▼ pour redescendre dans l'historique des commandes.
- ctrl + R (`^` + `R`) pour rechercher dans l'historique des commandes. \
  Après avoir pressé `^` + `R`, tapez quelques lettres. La dernière que vous avez tapé qui contient ces lettres apparait dans le prompt. Vous pouvez affiner la recherche en tapant plus de lettres, ou appuyer à nouveau sur `^` + `R` pour rechercher la commande précédente.
- un double point d'exclamation (`!!`) permet de recopier la dernière commande.
- la touche "tabulation" (`tab`) permet d'activer l'autocomplétion. \
  si vous tapez quelques lettres puis que vous appuyez sur `tab`, bash va essayer de compléter ces quelques lettres pour former la commande (ou option, ou nom de fichier, ...) qui correspond. \
  S'il y a plusieurs possibilités, ça ne fera rien : bash ne sait pas que choisir. En revanche, vous pouvez appuyer deux fois rapidement sur `tab` pour afficher la liste des possibilités.
  Si je tape "na" suivi de `tab`, il ne se passe rien : plusieurs commandes commencent par `na`.
  Si je tape "na" suivi de `tab` `tab` bash me propose toutes les commandes qui commencent par `na`:
  ```console
  $ na
  namei                      nautilus-autorun-software
  nano                       nautilus-sendto
  naptime.bt                 nawk
  nautilus   
  ```
  Si je tape "nan" suivi de `tab`, bash complète automatiquement avec la commande `nano`.

#pagebreak()

= Flux d'entrées/sorties et redirecteurs


== Les flux
Chaque processus (programme qui s'exécute) linux a une entrée et deux sorties (la sortie régulère et la sortie d'erreurs) :
#align(
  center,
  image("./illustrations/process-flux_numerote.png", width: 11.5cm)
)

=== Le flux d'entrée

Typiquement, l'entrée était le clavier du terminal physique tandis que les sorties étaient l'écran, ou l'imprimante dans le cas d'un téléscripteur.

Jusqu'à maintenant, nous n'avons utilisé l'entrée standard qu'à votre insu : par exemple, lorsque vous utilisez "nano", ce dernier est à l'écoute de l'entrée standard en permanance. Lorsque vous saisissez du texte au clavier, nano l'insère dans l'éditeur. Si vous appuez sur les touches `^X`, nano comprend que vous voulez quitter.\
_A chaque interraction, nano réécrit *tout le contenu de l'écran* pour être plus intuitif à utiliserœœœœœœ._
#align(
  center,
  image("./illustrations/process-flux_nano.png", width: 17cm)
)

=== Les flux de sortie

L'avantage de disposer de deux flux de sortie (la sortie et les erreurs) est qu'on peut les traiter différemment (par exemple, afficher les erreurs en rouge, voir même les rediriger vers un autre écran, ou fichier...).

Les sorties standard et l'erreur standard sont tout ce que vous voyez apparaitre dans votre terminal. Si vous utilisez la commande `cat` pour lire le contenu d'un fichier, cette dernière ne fait rien d'autre que de placer le contenu du fichier dans la sortie standard. Si jamais vous n'avez pas les droits de lire le contenu du fichier, `cat` vous le fera savoir en affichant une erreur via la sortie d'erreur.

```console
cat /etc/hosts
```
#align(
  center,
  image("./illustrations/process-flux_cat.png", width: 13cm)
)

```console
cat /etc/shadow
```
#align(
  center,
  image("./illustrations/process-flux_cat-erreur.png", width: 9.5cm)
)

Dans Linux, tout est fichier... les flux sont donc une forme particulière de fichiers "sans fin". \
En fait, il existe un caractère particulier appelé `EOF`("End Of File") qui désigne la fin d'un fichier. Si on écrit ce caractère dans un des flux, le shell considère que l'on a fermé le flux.

#pagebreak()
== Les redirecteurs de flux

Le shell propose ce qu'on appelle des _redirecteurs de flux_ . Comme leur nom l'indique, les redirecteurs de flux permettent de rediriger les dlux... vers ou depuis des fichiers.

#align(
  center,
  image("./illustrations/process-flux_redirecteurs.png", width: 15cm)
)


=== Redirecteur de flux d'entrée

Le redirecteur de flux d'entrée ("`<`") permet de rediriger le contenu d'un fichier vers l'entrée standard d'un processus.

Dans les faits, on l'utilise beaucoup moins souvent que les redirecteurs de flux de sortie.

L'exemple suivant nous montre l'utilisation du redirecteur d'entrée avec la commande `cut` (qui permet de ne garder qu'une colonne dans un fichier tableau) :
```console
$ cat fichier 
c1:	c2:	c3:
l1c1	l1c2	l1c3
l2c1	l2c2	l2c3
l3c1	l3c2	l3c3
l4c1	l4c2	l4c4
$ cut -f2 < fichier
c2:
l1c2
l2c2
l3c2
l4c2
```

=== Redirecteurs de flux de sortie

Le redirecteur de flux de sortie ("`>`") permet de rediriger la sortie d'une commande vers un nouveau fichier.\
Si le fichier n'existe pas, il le créée. \
Si le fichier existe déjà, il l'écrase.

```console
$ whoami > fichier
$ cat fichier 
prof
```


Le redirecteur de flux de sortie ("`>>`") permet de rediriger la sortie d'une commande à la fin d'un fichier.\
Si le fichier n'existe pas, il le créée. \
Si le fichier existe déjà, le contenu est ajouté à la fin.

```console
$ date > fichier
$ cat fichier 
sam. 01 févr. 2025 22:58:13 CET
$ whoami >> fichier 
$ cat fichier 
sam. 01 févr. 2025 22:58:13 CET
prof
$ date >> fichier 
$ cat fichier 
sam. 01 févr. 2025 22:58:13 CET
prof
sam. 01 févr. 2025 22:59:54 CET
$ date > fichier 
$ cat fichier 
sam. 01 févr. 2025 23:00:06 CET
```


Le redirecteur de flux d'erreur ("`2>`") permet de rediriger les erreurs d'unes commande vers un nouveau fichier.\
Si le fichier n'existe pas, il le créée. \
Si le fichier existe déjà, il l'écrase.
```console
$ cat /etc/shadow 2> erreurs.log
$ cat erreurs.log
cat: /etc/shadow: Permission non accordée
```

Le redirecteur de flux d'erreur ("`2>>`") permet de rediriger les erreurs d'unes commande vers la fin d'un fichier.\
Si le fichier n'existe pas, il le créée. \
Si le fichier existe déjà, les erreurs sont ajoutées à la fin.


On peut combiner les redirecteurs :
```console
$ cat /etc/shadow 2> erreurs.log > sortie.txt
```

Le redirecteur ("`2>&1`") permet de rediriger la sortie *et* les erreurs d'unes commande vers un même nouveau fichier.\
Le redirecteur ("`2>>&1`") permet de rediriger la sortie *et* les erreurs d'unes commande vers la fin d'un même fichier.\

#pagebreak()

=== Le pipe `|`

Le pipe (_"tube"_) permet de rediriger la sortie standard d'une commande vers l'entrée standard d'une autre commande.
#align(
  center,
  image("./illustrations/pipe.png", width: 18cm)
)






#pagebreak()


#bibliography("./bib.yml", style: "ieee", full: true)