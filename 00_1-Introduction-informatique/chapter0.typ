#import "@local/it-course:0.1.0" : *
#import "@preview/sourcerer:0.2.1": code


#show: chapter.with(
  subject: "Système 1",
  subject-subtitle: "Découverte de linux",
  topic: "Chapitre 0",
  subtitle: "Concepts de base de l'informatique",
  illustration: image("./couverture.png", width: 15cm),
  author: "Guillaume BITON",
  credit: "Droits d'exploitations accordés à l'ECE",
  licence: [Ce document est protégé par la licence CC BY-NC 4.0 https://creativecommons.org/licenses/by-nc/4.0/)],
  version: "1.0",
  lang: "fr",
  logo: image("../.assets/gbweb-ece.png", width: 9cm)
)

#heading(level: 1, numbering: none)[INTRODUCTION]

Ce chapitre ne s'inscrit pas directement dans le syllabus.
Dans les quelques pages qui vont suivre, nous n'allons pas rentrer dans le vif du sujet (à savoir le _Système d'Exploitation Linux_), mais nous allons commencer par _prendre un peu de hauteur_.

En effet, avant de prétendre devenir des virtuoses de l'informatique, il me semble opportun de revenir ensemble sur quelques questions essentielles comme :

- Qu'est-ce qu'un ordinateur ?
- D'où est ce que cela vient ?
- Comment cela fonctionne ?


Bien évidemment, l'histoire de l'informatique, la théorie derrière cette science passionnante, les principes mathématiques, physiques, algorithmique qui l'animent... sont des thèmes qui remplissent des bibliothèques et des parcours universitaires entiers.


Mais je vous propose de survoler ensemble les grandes lignes, et je tâcherai au fil des pages de vous proposer des liens vers des _articles et des vidéos de vulgarisation qui permettront aux plus curieux d'approfondir le sujet_.

#pagebreak()

= Un peu d'histoire

== Les prémices

Dans les années 1820, le britannique Charles Babbage conçoit une machine capable d'effectuer des calculs polynomiaux et permettant ainsi de calculer très rapidement et avec beaucoup de précision des fonctions logarithmiques et trigonométriques : la machine à différences.

#wrap-figure(
  width: 8.5cm,
  align: right,
  caption: [Machine à différences de Charles Babbage (au Science Museum de Londres #cite(<babbage-difference-engine>)).],
  [Les techniques métallurgiques de l'époque n'offraient pas assez de précision dans la réalisation des pièces mécaniques, et cette machine ne donna pas de résultats satisfaisants du vivant de Babbage, mais inspira à Babbage une invention plus révolutionnaire encore : la machine analytique.
  
  La machine analytique n'est rien d'autre qu'un ordinateur... mécanique. Si Babbage ne put jamais la produire (il passa sa vie à en améliorer perpétuellement les plans et, là aussi, les techniques industrielles manquaient de précision pour les besoins de cette extraordinaire invention), il nous laissa une quantité de documents, dont des plans détaillés qui décrivent ni plus ni moins le fonctionnement d'un ordinateur.
  Comme votre ordinateur, cette machine était dotée d'une unité de calcul arithmétique, d'une mémoire, et pouvait être programmée (au moyen de cartes perforées inspirées des métiers à tisser Jacquard... comme le fera IBM près d'un siècle plus tard et jusque dans les années 70). Dotée de contrôles de flux (boucles, conditions), la machine était "Turing-complète", ce qui signifie qu'elle aurait en théorie pu faire fonctionner n'importe quel programme.],
  image("./illustrations/01_machine-analytique.png")
)

Ada Lovelace écrivit, au cours de sa courte vie (elle mourut à 36 ans, en 1852) le premiers programme informatique de l'histoire. Conçu pour la machine de Babbage, ce programme permet de calculer les nombres de Bernoulli en utilisant des procédés révolutionnaires comme les boucles conditionnelles.

#idea()[
  == Allez voir sur YouTube #youtube
  "L'ordinateur à vapeur" sur la chaine Scientory : https://www.youtube.com/watch?v=_SyOigrbeQs
]
 

== Les premiers calculateurs

Au cours de la seconde guerre mondiale, on voit apparaitre de monstrueuses machines électromécaniques telles que le fameux Colossus Anglais (qui a permis de casser le code de Lorenz... et aux aliés de gagner la guerre), le Harvard Mark I d'IBM (qui servit notamment dans le cadre du projet Manhattan) ou encore l'ENIAC.

Ces machines de plusieurs tonnes consomment une énergie considérable (autant qu'un réacteur d'avion de ligne pour l'ENIAC).
Elles permettent d'effectuer au mieux quelques opérations mathématiques simples par seconde.

Ces machines ne sont pas tout à fait considérées comme des ordinateurs mais bien comme des calculateurs car elles ne peuvent pas stocker leur programme en mémoire.

== Les premiers ordinateurs

A partir de 1949 apparaissent les premiers ordinateurs à part entière. C'est à dire des machines répondant aux critères suivants :
- Qu'elle soit *électronique*
- *Numérique* (et non analogique)
- Qu'elle soit *programmable*
- Qu'elle puisse exécuter les quatre *opérations élémentaires* (addition, soustraction, multiplication, division) et, le plus souvent, qu'elle puisse extraire une racine carrée ou adresser une table qui en contient
- Qu'elle puisse exécuter des *programmes enregistrés en mémoire*

On peut citer le _BINAC_, le  _Ferranti Mark I_ et bien sur l'_UNIVAC_.

Ces machines utilisaient des milliers du tubes à vide pour fonctionner. Ces tubes étaient très peu fiables et cela rendaient les ordinateurs presque inutilisables.

== L'apparition du transistor

Au milieu des années 50, l'apparition du _transistor_ permet de construire des ordinateurs moins volumineux, moins consommateurs, moins chers et surtout incroyablement plus fiables qu'avec les tubes à vides. Cela rend la technologie largement plus accessible (au-delà du prix de la machine elle-même, il n'est plus nécessaire de disposer d'une armée de techniciens travaillant sans cesse à en remplacer les composants tombés en panne, et la machine est rendue opérationnelle presque 100% du temps).

Si les modèles qui apparaissent au cours des années 50 sont nombreux, IBM domine très largement le marché avec des machines comme le IBM 7000.

Pendant les années 60, des machines comme le IBM 360/75 avec son million d'opérations par seconde a été une pierre angulaire du programme Apollo.

== Une évolution exponentielle

En 1971, Intel commercialise le premier microprocesseur : le _4004_.
#wrap-figure(
  width: 5.5cm,
  align: left,
  caption: [Le Intel 4004],
  [Ce composant propose une puissance de calcul comparable à l'ENIAC :
    - Sur une surface de 10mm2 et un poids de quelques grammes (165m2 et 27 tonnes pour l'ENIAC)
    - Pour une consommation de 0,5W (150 000W pour l'ENIAC)
    - Pour un prix équivalent à 450\$ d\'aujourd\'hui (plus de 500 000\$ actuels pour l'ENIAC)],
  image("./illustrations/03_intel-4004.jpg")
)

Alan Moore théorisera en 1975 que le nombre de transistors sur une puce de silicium doublera tous les deux ans, à coût constant...
Cette loi s'est avérée étonnamment exacte...

Aujourd'hui, un smartphone à 500€ contient plus de 10 000 000 000 de transistors (le Intel 4004 en contenait 2 300) qui fonctionnent à une fréquence d'horloge de plus de 2 000 000 000 de Hertz (700 000 pour le Intel 4004).

#info()[
    Si vous vous demandez ce qu'est une fréquence d'horloge, un Hertz, ou même un transistor, ne vous inquiétez pas : vous découvrirez ces notions et surtout leur rapport aux performances d'un ordinateur au @theorie (plus précisément @fonctionnement-ordinateur).
]

Il est presque impossible de comparer différentes générations de processeurs tant leurs architectures, leurs caractéristiques et leurs capacités diffèrent.
Une des caractéristiques permettant de définir la puissance d'un processeur est le nombre d'opérations par secondes qu'il peut effectuer. Par exemple, l'IBM 360/75 (qui permit d'envoyer l'homme sur la Lune) a été le premier a passer le cap du million d'opérations par seconde... là où le processeur de votre PC portable effectue des dizaines de milliers de millions d'opérations par seconde. Mais il faut notamment prendre en compte le fait que les processeurs modernes peuvent effectuer des opérations bien, bien plus complexes qu'à l'époque, avec des nombres bien plus grands et précis, et qu'ils disposent de fonctionnalités très avancées (prédiction de branchement, pipelining...) qui leur permettent d'effectuer en un seul cycle, ce qui pouvait demander des dizaines, voire des centaines de cycles aux processeurs plus anciens.
Ainsi, on peut considérer qu'une requête à Chat GPT (traitées en une seconde aujourd'hui) aurait nécessité plusieurs mois de calcul à un IBM 360/75 (ceci est purement théorique : en réalité, le mainframe d'IBM ne disposait, au mieux, que d'1Mo de RAM là où ChatGPT en nécessite des milliers... et ne disposait pas d'une architecture adaptée à ce type de calculs).

Ce qu'il faut retenir, c'est que vous disposez tous aujourd'hui dans vos poches de machines d'une puissance absolument phénoménale, capables d'effectuer des opérations relativement complexes à une vitesse hallucinante, et de stocker des quantités de données que personne n'aurait pu imaginer il y a quelques dizaines d'années.


#pagebreak()

= Un peu de théorie <theorie>

== Composition d'un ordinateur

Un ordinateur est composé :
- D'un CPU (pour Central Processing Unit, ou "Unité Centrale de Calcul")
- De différentes mémoires
- De périphériques d'entrée / sortie

=== Le CPU

Appelé, par abus de langage, "processeur" (un ordinateur dispose en réalité de plusieurs types de processeurs, le CPU n'est qu'un d'eux), le CPU est en quelques sortes le "cerveau" de l'ordinateur. C'est lui qui effectue les opérations mathématiques et logiques.
Comprendre les bases de son fonctionnement me semble essentiel pour prétendre devenir un bon technicien informatique, et nous nous y attellerons en @fonctionnement-ordinateur.

#wrap-figure(
  width: 4.5cm,
  align: right,
  [Il ne sait effectuer qu'un nombre restreint d'opérations (de l'ordre du millier sur un processeur moderne, un peu moins de 500 pour un processeur des années 2000), et ces opérations sont relativement simples (additionner, comparer, inverser des nombres) mais il est capable d'en effectuer plusieurs milliards par seconde.],
  image("./illustrations/04_cpu.jpg")
)


=== Les mémoires

Un ordinateur dispose de différents types de mémoires, toutes primordiales pour son fonctionnement :
- *La mémoire de masse* (que l'on a tendance à appeler "mémoire de stockage" par abus de langage) : typiquement le SSD de votre ordinateur sur lequel sont stockés le système d'exploitation, vos programmes, vos fichiers, ...
  Il s'agit du type de stockage le plus lent, mais il est persistant (les informations restent stockées dans la durée), dense et peu cher (ce qui permet d'en avoir en quantité).
- *La mémoire vive* (aussi appelée "mémoire centrale", ou "RAM") : utilisée par le processeur pour stocker des informations utiles au cours du fonctionnement des programmes. Son contenu est perdu lorsqu'elle n'est plus alimentée électriquement.
  Cette mémoire n'est pas persistante, plus chère et moins dense que la mémoire de masse, mais elle est aussi plus rapide.
- *La mémoire cache* qui permet aux processeurs de stocker des informations au cours de leur traitement.
  Cette mémoire est extrêmement rapide. Mais elle est aussi très chère. Elle n'est donc disponible qu'en petite quantité.
  Nous pourrions également évoquer les registres qui sont une sorte de super-cache.

#align(center, image("./illustrations/05_comparaison-memoires.png", width: 12cm))

=== Les périphériques d'entrées / sorties

Un ordinateur, quel qu'il soit, n'a absolument *aucun* intérêt s'il ne peut, d'une manière ou d'une autre, interagir avec le monde extérieur. Imaginez un ordinateur incapable de recevoir des instructions, ni même de communiquer ses résultats...

Les périphériques d'entrées / sorties peuvent être catégorisés de bien des manières, et ils sont tellement nombreux et différents qu'il serait presque impossible d'en établir une catégorisation.
Les premiers qui viennent à l'esprit sont bien souvent :
- L'écran
- Le clavier et la souris
- L'imprimante
- ...

Mais aujourd'hui, votre ordinateur ne vous serait par exemple (presque) d'aucune utilité s'il n'était pas doté d'une carte réseau par exemple (pour se connecter à d'autres machines, à Internet...).

On pourrait citer mille autres exemples comme les différents capteurs (GPS, lecteur d'empreintes digitales, ...), les casques de réalité virtuelle, les webcams... ou bien des périphériques à usage professionnel (lecteur de carte à puce, de code-barre, ...) voir même industriel (CNC) ou scientifique.

#pagebreak()

== Fonctionnement d'un ordinateur <fonctionnement-ordinateur>

Je vous propose de commencer par "zoomer" sur le composant "atomique" de votre ordinateur (le transistor), puis de prendre progressivement de la hauteur pour en arriver à une vue d'ensemble.

=== Le transistor
#wrap-figure(
  width: 1.5cm,
  align: right,
  caption: [Un transistor],
  [Un transistor est un composant électronique qui peut être utilisé comme un interrupteur.
Il dispose de trois connecteurs (la base, le collecteur et l'émetteur). Si on applique une tension à sa base, alors il laisse passer le courant entre le collecteur et l'émetteur. Sinon, il bloque le courant. Dit plus simplement, brancher une source de tension (comme une simple pile) sur son connecteur de commande (la base) revient à pousser l'interrupteur et fermer le circuit entre le collecteur et l'émetteur.],
  image("./illustrations/06_transistor-illu.png")
)

#align(
  center,
  figure(
    image("./illustrations/07_transistor.png", width: 14cm),
    caption: [Schéma d'un transistor utilisé en mode bloqué/saturé (interrupteur)],
  )
)

=== Portes logiques
Ce qui nous intéresse dans le cadre de ce cours est qu'en branchant correctement une paire de transistors, on peut former des circuits logiques simples que l'on appelle "portes logiques".

#align(
  center,
  figure(
    image("./illustrations/08_logic-gates.png", width: 16cm),
    caption: [Circuits logiques de base à partir de transistors],
  )
)

=== Représentation symbolique
Pour mieux comprendre comment on peut faire de la logique avec des interrupteurs, définissons une représentation symbolique simple :
#{
  show table.cell: it => {
    if it.y == 0 {
      set text(white)
      strong(it)
    } else {
      it
    }
  }
  align(
    center,
    table(
      columns: (auto, auto, auto),
      fill: (x,y) =>
        if y == 0 { colors.at("blue-gray").border },
      inset: 10pt,
      align: horizon,
      table.header(
        [*Etat électronique*], [*Valeur binaire*], [*Valeur logique*],
      ),
      [Tension électrique positive], [1], [VRAI],
      [Tension électrique nulle], [0], [FAUX],
    )
  )
}

A la lumière de cette symbolique, étudions la porte logique "ET" :
- Si on applique une tension *positive* au point A et une tension *positive* au point B, alors on obtient une tension *positive* en sortie.
- Si on applique une tension *positive* au point A et une tension *nulle* au point B, alors on obtient une tension *nulle* en sortie.
- Si on applique une tension *nulle* au point A et une tension *positive* au point B, alors on obtient une tension *nulle* en sortie.
Ce n'est pas forcément très parlant...

Mais en termes logiques, cela donne :
- Si A est *vrai* et que B est *vrai*, alors la sortie est *vraie*
- Si A est *vrai* et que B est *faux* alors la sortie est *fausse*
- Si A est *faux* et que B est *vrai*, alors la sortie est *fausse*
Le circuit applique donc une logique "ET" : *la sortie n'est vraie que si les deux entrées sont vraies*.

Deux simples transistors nous permettent donc de faire de la logique... à condition que l'on associe des valeurs symboliques (*vrai* ou *faux*, *0* ou *1*) à des facteurs physiques (*tension* ou *absence de tension*, *courant* ou *absence de courant*).

En poussant un peu plus loin cette association symbolique, on peut également faire compter les transistors...

On l'a vu, il est facile d'associer des valeurs numériques (0 et 1) aux états électriques que peut prendre le transistor. \ 
Si vous vous demandez comment on peut compter avec seulement des 0 et des 1, je vous rappelle que vous comptez depuis des années avec seulement 10 symboles (0, 1, 2, 3, 4, 5, 6, 7, 8 et 9).

Si je vous demande d'additionner 37 et 185, vous allez faire :
- L'addition des unités : 5 et 7 font 12. Vous gardez *2* unités et retenez "1" en retenue.
- L'addition des dizaines : 3 et 8 font 11. Sans oublier la retenue qui nous amène à 12. On a donc *2* dizaines et à nouveau une retenue.
- Les centaines : votre 1 auquel on ajoute la retenue. Donc *2*.
Le résultat est *222*.

En binaire, on fait exactement la même chose. Additionnons 100101 et 10111001 :
- 1 et 1 font 10. Je garde donc *0* et j'ai une retenue de 1
- 0 et 0 font 0, avec ma retenue, cela fait *1*.
- 1 et 0 font *1*.
- 0 et 1 font *1*.
- 0 et 1 font *1*.
- 1 et 1 font 10. Je garde donc *0* et j'ai une retenue de 1.
- 0 et ma retenue me donne *1*.
- Il ne reste qu'un *1*.
Mon résultat est donc *11011110*.

Devinez quoi : 
- *100101* en binaire est égal à *37* en décimal
- *10111001* en binaire est égal à *185* en décimal
- *11011110* en binaire est égal à *222* en décimal

Comment faire cette conversion ? \
C'est assez simple : quand on compte en base N, on dispose de... N symboles. \
Quand on lit un nombre en base N, on commence par le chiffre le plus à droite (au rang "0") et on progresse vers la gauche (le rang augmentant de 1 à chaque fois qu'on se décale vers la gauche : un nombre de 5 chiffres va donc jusqu'au rang 4). \
Le chiffre le plus à gauche sera noté $c_0$, puis $c_1$, ... Et on fait :\

$ sum_(k=0)^n c_k * N^k $

En base 10 (N = 10), le nombre 185  (composé de 3 chiffres, n=3) nous donne :

#align(
  center,
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [$c_2$], [$c_1$], [$c_0$],
    [1], [8], [5],
  )
)
Quand on lit le nombre "185", on fait en fait :
$ sum_(k=0)^3 c_k * 10^k
    &= 1*10^2 + 8*10^1 + 5*10^0 \
    &= 1*100 + 8*10 + 5*1 \
    &= 185 $

En base 2 (N = 2), le nombre 10111001 (composé de 8 chiffres, n=8) nous donne :
#align(
  center,
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [$c_7$], [$c_6$], [$c_5$], [$c_4$], [$c_3$], [$c_2$], [$c_1$], [$c_0$],
    [1], [0], [1], [1], [1], [0], [0], [1],
  )
)
Quand on lit le nombre "10111001", on fait en fait :
$ sum_(k=0)^8 c_k * 10^k
    &= 1*2^7 + 0*2^6 + 1*2^5 + 1*2^4 + 1*2^3 + 0*2^2 + 0*2^1 + 1*2^0 \
    &= 1*128 + 0*64 + 1*32 + 1*16 + 1*8 + 0*4 + 0*2 + 1*1 \
    &= 185 $

*Bref* : il est tout à fait possible (et même assez facile) de faire des calculs avec seulement deux symboles.

Et on peut facilement concevoir des circuits pour le faire de manière électronique :
#align(
  center,
  [#figure(
    image("./illustrations/09_additionneur.jpg", width: 17cm),
    caption: [Circuits additionneur composé d'une vingtaine de transistors]
  )
  #label("additionneur")
  ]
)

=== Bascules

En assemblant les transistors d'une certaine manière, on peut créer ce que l'on appelle des "bascules". Ce sont des circuits dont la sortie ne dépend pas uniquement de l'état des entrées à un instant *t* (comme les différents circuits que nous avons évoqués jusqu'ici), mais également de leur état précédent. On introduit donc une notion temporelle, et on peut donc concevoir une logique "séquentielle". \
Avec cette subtilité, en apparence anodine, apparait un monde de possibilités.
Ainsi, on peut concevoir des registres (des mémoires), et "cadencer" le fonctionnement des circuits.
#align(
  center,
  figure(
    image("./illustrations/10_d-latch.jpg", width: 15cm),
    caption: [Circuit de type "bascule" composé d'une douzaine de transistors],
  )
)

Vous pouvez voir sur ce schéma que certaines entrées sont labelisées "Clk" pour "clock" (ou horloge).
En logique séquentielle, la notion d'horloge est primordiale : on va utiliser un signal électrique carré (qui passe successivement d'une tension nulle à une tension positive, à l'infini) pour *cadencer* le fonctionnement des circuits. Cela permet à la fois de "rythmer" le circuit (on câble les transistors pour que les bascules changent d'état à chaque fois que le signal change) et pour le "synchroniser" (pour que tous les éléments du circuits travaillent au même rythme).
#align(
  center,
  figure(
    image("./illustrations/11_clock-signal.png", width: 13cm),
    caption: [Signal carré qui peut être utilisé comme horloge],
  )
)

#info()[
  *Résumons un peu :* en assemblant quelques transistors, on peut concevoir des circuits permettant de résoudre des problèmes logiques (_"je veux que le résultat soit vrai uniquement si les deux entrées sont vraies"_), des problèmes mathématiques (additionner deux nombres) et même des logiques séquentielles (_"si l'état précédent des entrées était X et que l'état actuel est Y, alors je veux Z en sortie"_, ou encore _"garde cette valeur en sortie jusqu'à ce que j'applique une tension à l'entrée de remise à zéro"_, ou même _"fais une nouvelle séquence à chaque fois que l'état de l'entrée Clk change"_).
]
=== Assemblage de circuits

En assemblant entre eux des circuits simples, on peut accomplir des fonctions complexes.

==== Décodeur

Un décodeur est un circuit très simple : il dispose de n entrées et de $2^n$ sorties.
A chaque combinaison de valeurs d'entrées correspond une sortie.

Ci-dessous, un décodeur 2 bits : quand l'entrée est à "00", la première sortie (I0) est à 1 et les trois autres (I1, I2, I3) à 0, quand l'entrée est à "01", la deuxième sortie (I1) est à 1 et les trois autres à 0... et ainsi de suite. \

L'illustration montre deux décodeurs : le premier est détaillé pour que vous voyez les portes logiques utilisées et le second est la représentation symbolique (on ne s'amuse pas à représenter toutes les portes logiques à chaque fois qu'on veut inclure un décodeur). 

#align(
  center,
  [
    #figure(
      image("./illustrations/DIY-cpu/Decoder.png", width: 15cm),
      caption: [Un décodeur deux bits],
    )<decodeur>
  ]
)

Ce décodeur est composé de 12 transistors. \
\

Vous allez très vite voir l'utilité d'un décodeur : il permet de sélectionner un entrée, une sortie, ou même tout un circuit.

==== Registre

Un registre n'est rien d'autre qu'une mémoire.
Elle dispose d'un certain nombre de "cases". Chaque case dispose d'une adresse (une combinaison de bits, c'est à dire un nombre) et permet de stocker une combinaison de bits (c'est à dire un nombre).

Ci-dessous, un registre deux bits : il permet de stocker quatre valeurs de deux bits.
#align(
  center,
  [
    #figure(
      image("./illustrations/DIY-cpu/Registry.png", width: 17cm),
      caption: [Un registre deux bits],
    ) <registre>
  ]
)

Il dispose de 5 entrées : 2 bits d'adresse, 2 bits de valeur d'entrée, et 1 bit pour activer le mode "écriture". Il dispose de 2 sorties : les 2 bits que l'on lit.

Ainsi, si on veut stocker la valeur "01" à l'adresse "10", il suffit de mettre les bits de valeur d'entrée à "0" et "1", les bits d'adresse à "1" et "O" et d'activer (mettre à 1) le bit d'écriture.

Si on veut lire la valeur stockée à l'adresse "00", on met les bits d'adresse à "0" et "0" et on regarde les bits de sortie.

Pour faire ce registre, on a utilisé :
- 2 décodeurs 2 bits (1 pour activer l'écriture sur la bonne case en fonction de l'adresse et un pour mettre en sortie les bits correspondant à la case de l'adresse)
- 12 portes "ET"
- 2 portes "OU" à 4 entrées
- 8 bascules de type "D" (chaque bascule permet de stocker 1 bit)
Pour faire cela, il nous a fallu... *490 transistors* !

=== Assemblage d'assemblage : un CPU

Plus on met ensemble de circuits différents, et plus on peut faire des choses nombreuses et complexes... Et plus la fréquence du signal d'horloge est élevée, et plus on fait ces choses rapidement.

Pour vous expliquer jusqu'au bout le fonctionnement de votre ordinateur, j'ai utilisé un simulateur de circuits logiques pour faire un CPU à partir de portes logiques et de bascules "de base" :
#align(
  center,
  image("./illustrations/DIY-cpu/whole-cpu.svg", width: 17cm)
)

Le schéma ci-dessus regroupe les portes logiques en circuits (un additionneur comme sur la @additionneur, un registre comme sur la @registre, un décodeur comme sur la @decodeur...).

Ce processeur est doté d'une mémoire programmable de 16 cases de 8 bits (nous n'en utiliseront que 6). On peut donc exécuter des programmes de 16 instructions.

Il utilise un OPcode de 2 bits et dispose de 4 fonctions :
- Additionner (ADD - OPcode 00) un nombre et la valeur d'une case du registre, et mettre le résultat dans le buffer de sortie
- Stocker (STOR - OPcode 01) la valeur qui est dans le buffer de sortie dans une des cases du registre
- Charger (LOAD - OPcode 10) la valeur qui est dans une des cases du registre dans le buffer de sortie
- Ecrire (SET - OPcode 11) un nombre dans une des cases du registre

Les deux bits d'OPcode vont être acheminés vers des décodeurs et serviront à "activer" les parties du circuit nécessaires à la réalisation de la fonction. En d'autres termes, selon la valeur des deux bits d'OPcode on va allumer les sous-circuits dont on a besoin.

On utilise ensuite deux bits pour le premier opérande (le premier "argument" de la fonction). L'opérande aura différent usages selon la fonction utilisée. Par exemple, dans le cas de la fonction "additionner", le premier opérande sert à définir l'adresse de la case du registre qui contient le nombre que l'on veut additionner.

Enfin, certaines fonctions utiliseront un deuxième opérande (de deux bits également). Par exemple, la fonction "additionner" utilise le deuxième opérande pour définir le nombre que l'on souhaite additionner à la valeur qui se trouve dans la case dont l'adrese est définie par la première opérande.

#idea()[
  Nous verrons en classe le processeur en fonctionnement et, d'ici là, je vous enverrai une vidéo commentée.
]

#info()[
  Vous vous en doutez, un ordinateur doté de seulement 4 fonctions et capable de manipuler des nombres de 0 à 3 ne permettrait pas de faire grand-chose...
  Votre ordinateur manipule des nombres de 64 bits et dispose de centaines de fonctions. Autant vous dire qu'il serait délicat d'essayer de le simuler avec des portes logiques.
  Le CPU que je vous ai conçu pour but d'illustration est très, très, très simple : il est extrêmement limité et il lui manque de nombreux composants de base... Mais il utilise déjà près de 900 transistors !
]

#info()[
  Le processeur de votre ordinateur est composé de milliards de transistors qui changent d'état plusieurs milliards de fois par seconde (ils sont cadencés par un signal d'horloge qui oscille selon des fréquences en Giga Hertz, donc qui changent d'état toutes les nanosecondes... ou moins).
]

#pagebreak()

== Programmation d'un ordinateur

=== Le code machine
Au chapitre précédent, je vous ai parlé d'OPcode et d'opérandes.

Je vous ai dit qu'on programmait notre CPU sur 6 bits : 2 bits d'OPcode, 2 bits pour le premier opérande et 2 bits pour le second opérande.

Ainsi, si le code "011011" peut se décomposer en :
- OPcode = 01 : on utilise la fonction numéro 1 du processeur
- Opérande 1 = 10 : on donne la valeur "10" (2 en décimal) au premier opérande
- Opérande 2 = 11 : on donne la valeur "11" (3 en décimal) au troisième opérande

Vous avez vu sur le schéma du CPU et lors de mes explications comment cela se traduisait par de simples branchements et assemblages de transistors.

A la lumière de cette explication, je vous propose le programme suivant :
#code(
  lang: "machine",
```machine
010011
000111
001011
001111
000010
000110
001010
001110
010000
000101
010100
001001
000010
000110
001010
001110
```)

Nous serons probablement tous d'accords pour dire que ce code est assez illisible...
Pourtant, c'est ce que votre processeur attend.

=== L'assembleur

Pour simplifier un petit peu, nous avons décidé de donner un nom aux fonctions et aux cases de registres, et de compter en décimal.
En remplaçant donc simplement les OPcodes par leur nom, et les opérandes par leur équivalent, cela donne :
#code(
  lang: "assembly",
```assembly
SET  R0, 1; 
SET  R1, 0; 
SET  R2, 0; 
SET  R3, 0; 

LOAD R0;    
LOAD R1;    
LOAD R2;    
LOAD R3;    

ADD  R0, 1; 
STOR R1;    

ADD  R1, 1; 
STOR R2;    

LOAD R0;    
LOAD R1;    
LOAD R2;    
LOAD R3;    
```)

On appelle ça du code assembleur. Pendant longtemps, ce fut le seul moyen de programmer un ordinateur.
Aujourd'hui encore, quand on a besoin d'écrire du code très optimisé, et très proche de la machine, c'est comme ça qu'on l'écrit.

Maintenant, je vous propose de commenter un peu ce code :
#code(
  lang: "assembly",
```assembly
SET  R0, 1;    # On écrit 1 dans R0 (case 0 du registre)
SET  R1, 0;    # On écrit 0 dans R1 (case 1 du registre)
SET  R2, 0;    # On écrit 0 dans R2 (case 2 du registre)
SET  R3, 0;    # On écrit 0 dans R3 (case 3 du registre)

LOAD R0;       # On charge (dans le buffer) R0
LOAD R1;       # On charge (dans le buffer) R1
LOAD R2;       # On charge (dans le buffer) R2
LOAD R3;       # On charge (dans le buffer) R3

ADD  R0, 1;    # On met dans le buffer 1 + <R0>      => Le buffer contient 1 + 1 = 2
STOR R1;       # On enregistre le buffer dans R1     => R1 contient maintenant 2

ADD  R1, 1;    # Met dans le buffer 1 + <R1>         => Le buffer contient 1 + 2 = 3
STOR R2;       # On enregistre le buffer dans R2     => R2 contient maintenant 3

LOAD R0;       # On charge (dans le buffer) R0       => Buff = R0 = 1
LOAD R1;       # On charge (dans le buffer) R1       => Buff = R1 = 2
LOAD R2;       # On charge (dans le buffer) R2       => Buff = R2 = 3
LOAD R3;       # On charge (dans le buffer) R3       => Buff = R3 = 0  
```)

#good()[
  A ce stade, vous devriez commencer à comprendre comment on peut programmer un ordinateur pour lui faire faire ce que l'on veut... bien qu'il ne comprenne que des états électriques "hauts" et "bas".
]


#info()[
  L'ordinateur de bord du LEM (Lunar Excursion Module) qui s'est posé sur la lune en 1969 exécutait un programme de plus de 65 000 lignes de code assembleur comme ci-dessus.
  #align(
    center,
    [
      #figure(
        image("./illustrations/agc-assembly.jpeg", width: 5cm),
        caption: [Margaret H. Hamilton à côté du code de l'AGC],
      )
    ]
  )
]


=== Langages de programmation

L'assembleur permet d'écrire du code machine de manière plus lisible, mais cela reste du code machine : il y a une totale bijection entre le langage machine et l'assembleur.
Ecrire de l'assembleur revient donc à s'adresser directement au processeur et donc en connaitre le "manuel".
L'avantage est que, pour peu que cela soit fait avec intelligence, cela donne un code parfaitement optimisé pour le processeur pour lequel le code est destiné.
Mais les inconvénients sont nombreux. Notamment  :
- Du code assembleur écrit pour un type de processeur ne fonctionnera *que* sur ce type de processeur.
- Ce code est long, complexe et fastidieux à écrire et à débugger.

C'est pourquoi, dès le début de l'informatique, furent inventés les *langages de programmation compilés*.
L'idée derrière tous les langages de compilations compilée est la même : on propose un langage permettant d'écrire sous forme compréhensive et codifiée la logique d'un programme. Pour chaque type de processeur, on écrit une moulinette capable de transformer ce langage en code assembleur. Et le code assembleur est ensuite assemblé pour donner du code machine.

#align(
  center,
  [
    #figure(
      image("./illustrations/11_c-to-assembly.jpg", width: 16cm),
      caption: [Programme permettant de calculer la somme des n premiers entiers positifs (source: http://what-when-how.com)],
    )
  ]
)

Le langage C, inventé en 1972 dans les Laboratoires Bell a été développé en même temps qu'Unix par Dennis Ritchie et Ken Thompson. Il est à la base de toute l'informatique moderne, et sa logique et son formalisme se retrouvent dans beaucoup de langages beaucoup plus modernes.
Bien qu'il ait plus de 50 ans, il est encore très présent dans le paysage informatique.

Aujourd'hui il existe de nombreux langages de plus haut niveau. Par "haut niveau", on veut dire "plus proche du langage naturel" tandis que par "bas niveau" on entend "proche du langage machine".
Un langage de haut niveau permet généralement de code plus facilement, plus rapidement et de manière beaucoup plus "lisible" que les langages de bas niveau.
Les langages de haut niveau reposent souvent eux-mêmes sur des langages de plus bas niveau.
Par exemple, le langage Python (l'un des plus utilisé de la planète aujourd'hui) est lui-même écrit en C. Python "traduit" en quelques sortes du code Python en code C.

Imaginez que vous voulez construire une maison et que vous deviez pour cela donner des instructions à un ouvrier.  
Si vous ne pouviez parler à votre ouvrier qu'en assembleur, il vous faudrait lui décrire un à un et dans le détail chaque geste qu'il doit effectuer de la pose de la première pierre jusqu'à la dernière couche de peinture (il ne comprendrait que des instructions comme "bouge le bras de tant de cm dans telle direction", "attrape l'objet" ou "déplace toi vers l'avant").  
Un langage bas niveau (comme le C) vous permettrait de lui expliquer comment faire un mur puis de lui dire "fais moi quatre murs".
Un langage haut niveau (comme le python) vous permettrait de lui décrire en quelques phrases la maison de vos rêves et de lui demander de vous la construire.

Plus un langage est haut niveau et moins il est "optimisé" dans le sens où il va lui falloir plus de temps CPU pour effectuer une tâche que si vous l'aviez décrite en assembleur... Mais ce n'est pas grave car nos ordinateurs sont devenus tellement rapides que l'on peut très largement se permettre de "gaspiller" des ressources.
Pour reprendre l'analogie de notre ouvrier, nous pourrions imaginer que, en lui décrivant un à un chaque geste qu'il doit faire pour construire la maison, nous aurions l'assurance qu'il n'effectue pas le moindre geste superflu pour la construire tandis que, en lui décrivant juste la maison de nos rêves, il risque de faire de nombreux allers-retours inutiles à son camion, à l'entrepôt, qu'il lui faille cinq gestes au lieu de deux pour poser une brique sur une autre... Mais ce n'est pas grave car cet ouvrier effectue plusieurs milliards de gestes par seconde. Donc, peut être qu'en lui parlant en haut niveau il va lui falloir trois fois plus de temps pour construire l'intégralité de la maison qu'en lui parlant en assembleur, mais on parle de 12 secondes en haut niveau contre 4 secondes en bas niveau. Nous, ce qu'on veut, c'est que notre maison soit prête en moins de trois mois, et si ça nous permet d'économiser des mois et des mois que nous aurions dû passer à lui décrire chaque geste à effectuer, alors ça vaut largement le coup.


Pour le dire autrement, les ordinateurs modernes sont devenus si incroyablement performants que l'on peut se permettre de sacrifier de l'optimisation d'exécution au profit de la simplicité d'écriture de code. On utilise notamment ce que l'on appelle des bibliothèques de fonctions qui comprennent des "kits" tout prêts de fonctions pour effectuer des tâches très complexes.

C'est grâce à cela que nous pouvons aujourd'hui utiliser des programmes incroyablement poussés : leur complexité à été décomposée en une multitude de couches de blocs fonctionnels qui, pris un à uns, sont simples, et que l'on a assemblé entre eux pour remplir des missions très complexes.

En 1982, Microsoft publie le tout premier "Flight Simulator 1.0". Il est écrit en Fortran (langage bas niveau) et cela ressemble à ça :
#align(
  center,
  image("./illustrations/12_FS1.png", width: 14cm),
)

Aujourd'hui, le descendant de ce simulateur de vol est Microsoft Flight Simulator 2024, et il ressemble à ça :
#align(
  center,
  image("./illustrations/13_FS24.jpg", width: 16cm),
)

#pagebreak()


#heading(level: 1, numbering: none)[POUR ALLER PLUS LOIN]

- #youtube #fr-FR Vidéo _"#link("https://www.youtube.com/watch?v=_SyOigrbeQs&ab_channel=Scientory")[L'Ordinateur à Vapeur !]"_ sur la #link("https://www.youtube.com/@Scientory")[chaine YouTube Scientory] 
- #youtube #en-US Vidéo _"#link("https://www.youtube.com/watch?v=be1EM3gQkAY&ab_channel=ComputerHistoryMuseum")[The Babbage Difference Engine #2 at CHM]"_ sur la #link("https://www.youtube.com/@ComputerHistory")[chaine YouTube du Computer History Museum]
- #article #en-UK Article _"#link("https://www.sciencemuseum.org.uk/objects-and-stories/charles-babbages-difference-engines-and-science-museum")[Charles Babbage’s Difference Engines and the Science Museum]"_ sur le site du #link("https://www.sciencemuseum.org.uk/")[Scien Museum de Londres] 
- #wikipedia Pages Wikipedia :
  - ENIAC
  - Histoire de l'informatique
  - AGC
- #web #en-US Simulateur #link("https://circuitverse.org")[CircuitVerse]
- #web #en-US Projet #link("http://boolr.me/")[BOOLR]
- #web #en-US Le projet de Ben EATER #link("https://eater.net/8bit/")[Build an 8-bit computer from scratch] (vidéos en anglais)
- #youtube #fr-FR Vidéo #link("https://www.youtube.com/watch?v=KsR7sZztx4U&ab_channel=Underscore_")[On a reçu l'étudiant qui a fabriqué son processeur] d'#link("https://www.youtube.com/@Underscore_")[Underscore\_] sur Simon, qui a repris le projet de Ben EATER (en français) 
- #web #en-US #link("https://github.com/chrislgarry/Apollo-11")[Le code source de l'AGC pour la mission Apollo 11] mis à disposition sur GitHub par le #link("https://mitmuseum.mit.edu/")[musée du MIT] 


#pagebreak()

#bibliography("./bib.yml", style: "ieee", full: true)
