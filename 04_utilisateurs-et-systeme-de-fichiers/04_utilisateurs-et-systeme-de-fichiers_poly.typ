#import "@local/it-course:0.1.0" : *
#import "@preview/sourcerer:0.2.1": code

#show: chapter.with(
  subject: "Système 1",
  subject-subtitle: "Découverte de linux",
  topic: "Chapitre 4",
  subtitle: "Utilisateurs & Système de fichiers",
  illustration: image("./couverture.png", width: 14cm),
  author: "Guillaume BITON",
  credit: "Droits d'exploitations accordés à l'ECE",
  licence: [Ce document est protégé par la licence CC BY-NC 4.0 https://creativecommons.org/licenses/by-nc/4.0/)],
  version: "1.0",
  lang: "fr",
  logo: image("../.assets/gbweb-ece.png", width: 9cm)
)

#heading(level: 1, numbering: none)[INTRODUCTION]

Dans ce chapitre, nous allons aborder les deux premières notions *concrètes* à la base de l'utilisation d'un système d'exploitation Linux : celle des *utilisateurs* et celle du *système de fichiers*.

#pagebreak()

= Les utilisateurs & les groupes

== Théorie

=== Notions générales

Pour utiliser un système d'exploitation Linux, il faut s'*authentifier*.

Les utilisateurs (humains ou systèmes) sont représentés par des *comptes utilisateurs*.

#idea()[
  Souvenez-vous que le *prompt* d'un shell bash par défaut vous donne le nom de l'utilisateur que vous êtes actuellement en train d'utiliser pour exécuter vos commandes :
  #align(
    center,
    image("./illustrations/01_prompt.png", width: 8cm)
  )
]

La plupart du temps, on créé un compte utilisateur pour chaque personne qui va utiliser le système. Il peut même arriver que l'on créée plusieurs comptes pour une même personne (par exemple un compte "normal" et un compte "administrateur" pour quand il doit effectuer des tâches sensibles). Les comptes sont protégés par mots de passes (on peut aussi employer d'autres moyens de sécurisation comme des cartes à puces, des clés physiques etc...).

Les comptes utilisateurs servent notamment à mettre en œuvre des politiques de permissions (qui a le droit de faire quoi et d'accéder à quoi sur le système) et à la traçabilité des opérations effectuées sur le système (on parle d'_audit logs_ : qui a fait quoi, et quand).

#warning()[
  Les comptes utilisateurs jouent donc un rôle très important dans la sécurisation des systèmes, et ont une valeur *juridique* : si une action illégale, malveillante et/ou une erreur professionnelle a été effectuée avec votre compte, vous en êtes responsable auprès du propriétaire du système (souvent votre employeur) et/ou aux yeux de la loi. Si vous n'êtes pas l'auteur de ces actions, on considèrera que vous êtes à minima responsable de ne pas avoir suffisamment protégé votre mot de passe, ou de l'avoir volontairement donné à quelqu'un de malveillant, ce qui vaut complicité.

  Votre compte utilisateur et votre mot de passe sont donc *précieux* et représentent votre *identité* sur le système.
]


Il existe des comptes utilisateurs qui ne représentent pas des humains mais des programmes, ou même des abstractions du système d'exploitation, on les appelle les *comptes systèmes*.

Linux propose également une notion de *groupes utilisateurs*.\
Les groupes utilisateurs permettent de représenter un ensemble d'utilisateurs et sont principalement utilisés dans la mise en œuvre  des politiques de permissions (qui a le droit de faire quoi et d'accéder à quoi sur le système).\
Il appartient à l'administrateur du système de décider comment il souhaite regrouper les utilisateurs. Par exemple, on peut décider de créer des groupes par services dans l'entreprise (un groupe "commerce", un groupe "personnel technique", un groupe "direction", ...) ou pour l'utilisation de certaines ressources (un groupe "traceur" pour ceux qui ont besoin d'utiliser des traceurs et un groupe "imprimante-3d" pour ceux qui ont besoin d'utiliser des imprimantes 3D)... ou même "géographiquement" (groupe "bâtiment A", groupe "1er étage"...).


Comme pour les comptes utilisateurs, il existe des groupes *groupes systèmes*.

=== Utilisateurs

#light-learn()[
  Dans linux, un utilisateur possède (entre autre), les propriétés suivantes :
  - *Un nom d'utilisateur* (la convention veut qu'on n'utilise que des lettres minuscules, des tirets, des underscores ou des chiffres et que l'on commence par une lettre
    #footnote[
      En réalité, Linux accepte des noms d'utilisateurs et de groupes contenant des majuscules, des points, des accents, ... mais ce n'est pas POSIX et vous prenez alors le risque que certains programmes ne fonctionnent pas correctement.
    ]<fn-name-conv> 
    ).
  - *Un UID* ("User IDentifier" ou "Identifiant utilisateur" : un nombre entier entre 1000
    #footnote[
      Les UID et GID de 0 à 999 sont traditionnellement réservés aux utilisateurs systèmes et aux groupes systèmes.
    ] <fn-low-id>
    et 65535
    #footnote[
      En réalité, Linux accepte des UID et GID bien, bien plus grands que 65535, ... mais ce n'est pas POSIX et vous prenez alors le risque que certains programmes ne fonctionnent pas correctement.
    ] <fn-max-id>
    unique pour chaque utilisateur).
  - *Un groupe principal
    #footnote[
      Chaque utilisateur peut appartenir à une infinité de groupes, mais il doit avoir un et un seul groupe principal.
    ]
    représenté par son GID* ("Group IDentifier" ou "Identifiant groupe" : un nombre entier entre 1000 #footnote(<fn-low-id>) et 65535 #footnote(<fn-max-id>) unique pour chaque groupe).
  - *Un répertoire personnel*. \
    C'est le répertoire dédié à l'utilisateur, dans lequel il peut stocker ses fichiers, ses programmes, ses paramètres... \
    Par convention, ce répertoire est placé dans `/home` et porte le nom de l'utilisateur _(pour l'utilisateur `bob`, ce sera donc `/home/bob`)_.
]


=== Groupes

#light-learn()[
  Dans linux, un groupe possède (entre autre), les propriétés suivantes :
  - *Un nom* (la convention veut qu'on n'utilise que des lettres minuscules, des tirets, des underscores ou des chiffres et que l'on commence par une lettre #footnote(<fn-name-conv>)).
  - *Un GID* ("Group IDentifier" ou "Identifiant de groupe" : un nombre entier entre 1000 #footnote(<fn-low-id>) et 65535 #footnote(<fn-max-id>) unique pour chaque groupe).
]

#pagebreak()

=== Le super-utilisateur (root)


Sous linux, il existe un utilisateur très particulier : l'utilisateur *root* (souvent appelé "super-utilisateur" ou, en anglais "superuser").

#light-learn()[Cet utilisateur a *tous les droits* sur le système.]

#warning()[
  Je ne peux pas insister assez sur le fait que *root* a *littéralement TOUS les droits*.\
  Il peut :
  - détruire le système entier d'une seule commande
  - accéder à *tous* les fichiers du système, quelque soient leurs permissions
  - supprimer un utilisateur et tous ses fichiers
  - ...
]

#light-learn()[
  Le *superutilisateur* se distingue par :
  - *Son nom d'utilisateur* : `root`
  - *Son UID* : `0`
  - *Son groupe principal* : `root` (dont le GID est `0`)
  - *Son répertoire personnel* : `/root`
]

#pagebreak()

== Commandes utiles

=== `whoami` (qui suis-je ?)

`whoami` est peut être la commande la plus simple sur Linux...

Tapez `whoami` (en anglais : "quisuisje") dans votre shell, et la commande vous donnera... votre nom d'utilisateur.

Dans un shell moderne avec un prompt "classique" cela n'a pas un grand intérêt (le prompt vous rappelle votre nom d'utilisateur à chaque fois), mais cela peut être utile quand :
- vous écrierez des scripts
- vous utiliserez des systèmes où vous êtes contraints d'utiliser des shells plus "rustiques"

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ whoami
prof
```


=== `id` (identifiants)

`id` permet d'obtenir l'UID, le GID ainsi que les IDs de tous les groupes auxquels un utilisateur appartient.

==== Manuel

#warning()[
  A chaque fois, je ne vous mettrai qu'un *extrait* du manuel comprenant les éléments les plus importants. A vous d'aller voir le manuel pour plus de précisions !
]

```console
NOM
       id - Afficher les identifiants d'utilisateur et de groupe effectifs et réels

SYNOPSIS
       id [OPTION]... [UTILISATEUR]...

DESCRIPTION
       Afficher les informations sur l'utilisateur et le groupe pour chaque UTILISATEUR spécifié, ou (si UTILISATEUR est omis) pour le processus actuel.

       -g, --group
              N'afficher que l'identifiant de groupe effectif
       -G, --groups
              Afficher tous les identifiants de tous les groupes
       -n, --name
              Afficher un nom plutôt qu'un nombre, pour -ugG
       -u, --user
              N'afficher que l'identifiant effectif
       --help afficher l'aide-mémoire et quitter.

       Sans aucune OPTION, quelques informations utiles sur l'identité sont affichées.

```

id accepte quelques options, notamment pour sélectionner quelles informations on souhaite obtenir.

On peut préciser un (ou des) nom(s) d'utilisateur(s) pour le(s)quel(s) on veut obtenir les informations.\ 
Si on n'en précise pas, ce sera pour l'utilisateur qui exécute la commande.

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ id
uid=1000(prof) gid=1001(prof) groups=1001(prof),4(adm),24(cdrom),27(sudo),105(lxd),1000(ssh)

prof@ece-sys-vm:~$ id -u djene eliot sem
1003
1004
1009
```

=== `passwd` (changer de mot de passe)

`passwd` permet de changer le mot de passe d'un utilisateur.

==== Manuel

```console
NOM
       passwd - Modifier le mot de passe d'un utilisateur
 
SYNOPSIS
       passwd [options] [LOGIN]
 
DESCRIPTION
       La commande passwd change les mots de passes des comptes utilisateurs.
       Un utilisateur normal ne peut changer que seon propre mot de passe,
       tandis que le superutilisateur peut changer le mot de passe de
       n'importe quel compte.

   Modifications du mot de passe
       Dans un premier temps, l'utilisateur doit fournir son ancien
       mot de passe, s'il en avait un.
       [...]
       Le nouveau mot de passe sera demandé deux fois à l'utilisateur.
       Le second mot de passe est comparé avec le premier.
       Ces deux mots de passe devront être identiques pour que le mot
       de passe soit changé.
       [...]
 
OPTIONS
       -d, --delete
           Supprimer le mot de passe (le rendre vide) d'un utilisateur.
           C'est une façon rapide de supprimer l'authentification par mot
           de passe pour un compte.

       -e, --expire
           Annuler immédiatement la validité du mot de passe d'un compte.
           Ceci permet d'obliger un utilisateur à changer son mot de passe
           lors de sa prochaine connexion.

       -l, --lock
           Verrouiller le mot de passe du compte indiqué. Cette option
           désactive un mot de passe en le modifiant par une valeur qui
           ne correspond pas à un mot de passe chiffré possible
           (cela ajoute un « ! » au début du mot de passe).

           Les utilisateurs avec un mot de passe verrouillé ne sont pas
           autorisés à le changer.
  
       -S, --status
           Afficher l'état d'un compte. Cet état est constitué de 7 champs.
           Le premier champ est le nom du compte. Le second champ indique
           si le mot de passe est bloqué (L), n'a pas de mot de passe (NP)
           ou a un mot de passe utilisable (P). Le troisième champ donne
           la date de dernière modification du mot de passe.
           Les quatre champs suivants sont : la durée minimum avant
           modification, la durée maximum de validité, la durée
           d'avertissement, et la durée d'inactivité autorisée pour
           le mot de passe.
           Les durées sont exprimées en jours.

       -x, --maxdays MAX_DAYS
           Set the maximum number of days a password remains valid.
           After MAX_DAYS, the password is required to be changed.

           Passing the number -1 as MAX_DAYS will remove checking a
           password's validity.
```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ passwd
Changing password for prof.
Current password: 
New password: 
Retype new password: 
passwd: password updated successfully
```

#info()[
  Linux n'affiche jamais les mots de passes, pas même des "\*" à la place des caractères que vous tapez.
]

#pagebreak()
=== `sudo` - usurpation d'identité

La commande `sudo` (*S*ubstitute *U*ser *DO*) permet de lancer une commande en utilisant les droits d’un autre utilisateur. 

Par défaut, l'utilisateur en question est le superutilisateur.

Bien sûr, l’utilisation de sudo est encadrée par des règles de sécurité strictes et très puissantes. On ne peut pas utiliser sudo pour effectuer n'importe quelle commande en utilisant les droits de n'importe quel utilisateur. Il faut y avoir été explicitement autorisé.

==== Manuel

```console
NAME
       sudo — execute une commande en tant qu'un autre utilisateur

SYNOPSIS
       sudo [-ABbEHnPS] [-C  num]  [-D  directory]  [-g  group]  [-h  host]
            [-p  prompt]  [-R  directory]  [-r role] [-t type] [-T timeout]
            [-u user] [VAR=value] [-i | -s] [command [arg ...]]

DESCRIPTION
       sudo allows a permitted user to execute a command as  the  superuser
       or  another user, as specified by the security policy.  The invoking
       user's real (not effective) user-ID is used to  determine  the  user
       name with which to query the security policy.

       The options are as follows:
       
       -D directory, --chdir=directory
               Run the command in the specified directory  instead  of  the
               current  working  directory.
       -g group, --group=group
               Run  the command with the primary group set to group instead
               of the primary group specified by the target user's password
               database entry.
       -u user, --user=user
               Run the command as a user other than the default target user
               (usually root).
       --      The -- is used to delimit the end of the sudo options.  Sub‐
               sequent options are passed to the command.

EXAMPLES
       The following examples assume a properly configured security policy.

       To get a file listing of an unreadable directory:
           $ sudo ls /usr/local/protected

       To edit the index.html file as user www:
           $ sudoedit -u www ~www/htdocs/index.html

       To view system logs only accessible to root and  users  in  the  adm
       group:
           $ sudo -g adm more /var/log/syslog
```


#pagebreak()

= Le système de fichiers

== Théorie

=== Système de fichiers

Dans Linux, on range les fichiers dans des répertoires, que l’on peut eux même mettre dans des répertoires etc…

Chaque fichier, et chaque répertoire a un *chemin d’accès*. \
On sépare les noms des fichiers et des répertoires par des slash (« / »). \
La base du système de fichiers est appelée la « *racine* », en anglais « *root* ».

#warning()[
  == Ne pas confondre :
  - L’utilisateur « `root` » qui est le super-utilisateur (UID 0)
  - Son répertoire personnel dont le chemin est « `/root` »
  - La racine du système de fichiers que l’on appelle « root » et dont le chemin est « `/` »
]


Le système de fichiers de Linux forme ce que l'on appelle une "arborescence" : elle peut être représentée sous la forme d'un arbre. \
Cet arbre n'a qu'un seul et unique tronc (que l'on appelle étrangement "racine" ou, en anglais `root`). De ce tronc partent des branches (les répertoires). Chaque branche peut supporter :
- d'autres branches
- des feuilles (les fichiers)

#align(
  center,
  image("./illustrations/arborescence1.png", width: 11cm)
)

Vous en conviendrez, cette représentation n'est pas très pratique.\ 
On en préfère donc une qui ressemble un peu moins à un arbre, mais beaucoup plus lisible :\
_(voir page suivante)_

#align(
  center,
  image("./illustrations/arborescence2.png", width: 8cm)
)

Textuellement, cela donne :
```
/
├── home
│   ├── alice
│   │   ├── documents
│   │   │   └── document1
│   │   └── fichier1
│   └── bob
│       └── fichier_a
└── var
    └── lib
```

#info()[
  Windows - que vous connaissez probablement mieux - fonctionne également avec un système de fichiers arborescent.\

  La principale différence est que dans Windows, il peut y avoir plusieurs racines ("Disque C:", "Disque D:", etc...).
]

#pagebreak()

=== Chemins d'accès

Chaque fichier, chaque répertoire possède :
- Un seul et unique *chemin absolu*. \
  Le chemin absolu est le chemin le plus court qui part de la racine (il commence donc toujours par un slash "`/`").
- Une infinité de de *chemins relatifs*. \
  Les chemins relatifs sont des chemins... depuis un répertoire spécifique.

#info()[
  - On utilise le point "`.`" pour désigner le répertoire courant (celui dans lequel on se situe).
  - On utilise deux points "`..`" pour désigner le répertoire parent (celui qui contient celui dans lequel on se situe).\
    La racine `/` est le seul répertoire qui n'a pas de répertoire parent. Pour la racine, `..` est égal à lui même.
  - On utilise `~` pour désigner le répertoire personnel de l'utilisateur courant.
]

Reprenons l'arborescence étudiée précédemment :
```
/
├── home
│   ├── alice
│   │   ├── documents
│   │   │   └── document1
│   │   └── fichier1
│   └── bob
│       └── fichier_a
└── var
    └── lib
```

- Le chemin absolu de "fichier_a" est :  `/home/bob/fichier_a`.
- Si on se trouve dans le répertoire personnel d'alice (dont le chemin absolu est `/home/alice`), on peut faire référence au fichier "document1" via le chemin relatif `./documents/document1`, ou tout simplement `documents/document1`.
- Si on se trouve dans le répertoire personnel d'alice, on peut faire référence au fichier "fichier_a" via le chemin relatif `../bob/fichier_a`
- Si on se trouve dans le répertoire personnel d'alice, on peut faire référence au répertoire "lib" via le chemin relatif `../../var/lib`. Mais dans ce cas, le plus simple serait sans doute d'utiliser le chemin absolu `/var/lib`.

#pagebreak()

=== Points de montages

Dans Linux, on "attache" les supports de stockage à des répertoires de l'arborescence.

On appelle cela des "montages" et les répertoires auquel on lie les supports sont appelés "points de montage".

#align(
  center,
  image("./illustrations/points-montages.png", width: 14cm)
)<illu-points-montages>


=== Les principaux répertoires de l'arborescence

- *bin (et sbin)* : Pour « binaires » et « super-binaires ». On y trouve les fichiers compilés exécutables (binaires) - ou plus simplement les programmes – nécessaires au fonctionnement primaire de l’ordinateur et à son démarrage. \
  Dans sbin, on trouvera les binaires dédiés à l’administration, voués à être utilisés par le super-utilisateur root.
#info()[
  A l’origine, les supports de stockage étaient très limités.\
  On devait par exemple démarrer son ordinateur sur une disquette puis échanger la disquette pour celle contenant nos programmes (traitement de texte par exemple) ou nos fichiers… C’est pourquoi on sépare ainsi les binaires nécessaires au démarrage des autres… \
  Aujourd’hui, on ne manque plus de place mais on trouve cela bien plus propre et pratique de continuer à bien ranger les choses.
]
- *boot* : on y trouve les fichiers nécessaires au démarrage (boot) de la machine. Notamment le noyau du système (kernel).
- *dev* : on y trouve les périphériques (devices) connectés à l’ordinateur.

#info()[
  Un des principes fondamentaux de Linux est que tout est fichier.\
  Ainsi, les périphériques apparaissent comme des fichiers. C’est ainsi que les concepteurs de Linux ont décidé d’implémenter la fameuse notion de machine virtuelle (voir chapitre 2) avec laquelle il est plus simple pour nous d’interagir.\
  Par exemple, le premier terminal branché à la machine sera représenté par /dev/tty0.\
  De même, vous avez pu voir dans #link(<illu-points-montages>)[l'illustration sur les points de montages] que le premier disque dur de la machine était représenté par `/dev/sda`. `/dev/sda` est un fichier qui représente le disque dur. Il doit être *monté* pour pouvoir en explorer le contenu.
]

- *etc* : pour « et caetera » : on y trouve ce qui n’a pas trouvé sa place ailleurs… \
  Essentiellement les fichiers de configuration du système et des applications.
- *home* : c’est ici que sont placés les répertoires personnels des utilisateurs.
- *lib* : où sont placées les bibliothèques utilisées par les programmes de /bin et /sbin.

#info()[
  On appelle bibliothèque des « catalogues » de fonctions logicielles regroupées ensemble. \
  Cela permet aux développeurs de pouvoir utiliser des fonctions toutes prêtes et ainsi gagner en temps, en propreté et efficacité du code mais aussi d’alléger les programmes.\
  Par exemple, la fameuse bibliothèque « stdio » (Standard Inpout/Output » contient tout ce qu’il faut pour gérer les entrées et sorties d’un programme (lecture de saisies depuis le terminal, écriture dans un fichier…). Pas besoin de réécrire ce code pour les milliers d’applications présentes sur l’ordinateur. Surtout qu’on les ferait sans doute beaucoup moins bien !
]

- *media* : c’est ici que sont « montés » les périphériques externes (clés USB…).
- *mnt* : ce répertoire est dédié au montage des disques.
- *opt* : on y place généralement les programmes optionnels (c’est-à-dire non nécessaires à l’utilisation régulière de la machine… les jeux par exemple).
- *proc* : qui est également une représentation de la machine virtuelle. On y trouve l’état de tous les composants du système. C’est un répertoire virtuel qui ne prend aucune place sur le disque. Par exemple, le fichier /proc/cpuinfo contient les informations détaillées du CPU à l’instant t.
- *root* : Le répertoire personnel du super-utilisateur « root ».
- *run* : encore un répertoire représentant la machine virtuelle. Celui-ci contient des informations sur les programmes (processus) en cours de fonctionnement (« running »)
- *sys* : similaire à proc (donc encore un répertoire représentant la machine virtuelle !) 
- *tmp* : festiné à stocker des fichiers temporaires. Il est régulièrement vidé par le système (à minima à chaque redémarrage).
- *usr* : pour Unix System Resources. Contient les ressources du système non nécessaires à son démarrage. \
  Comme à la racine, on y retrouve des répertoires `bin`, `sbin`, `lib…`
  La version "usr" de `bin`, `sbin` etc... contient les éléments *non* nécessaires au démarrage du système.
  `usr` contient également un répertoire « local » qui contient lui-même… `bin`, `sbin`, `lib`. Ils contiennent les élements spécifiques à cette machine. \
  Un répertoire `/usr/share` contient des ressources globales comme les fichiers de langue, la documentation… \
  #image("./illustrations/usr.png", width: 16.5cm)
- *var* : c’est ici que sont stockées les données.

=== Les permissions

Chaque fichier, chaque répertoire possède :
- Un utilisateur propriétaire
- Un groupe propriétaire
- Un « mode » sous la forme de trois digits sur 4 bits :
  - Le premier définit les droits de propriétaire
  - Le second définit les droits des membres du groupe propriétaire
  - Le troisième définit les droits de tous les autres utilisateurs

#warning()[
  Il est important de noter que le super-utilisateur aura toujours *tous* les droits sur n'importe quel répertoire ou fichier, quelques soient leurs permissions.
]

#{
  set table(
    stroke: none,
    gutter: 0.2em,
    fill: (x, y) =>
      if y == 0 { colors.at("blue").border }
      else if y == 2 { colors.at("blue").border.lighten(70%) }
      else { colors.at("blue").border.lighten(90%) },

  )

  show table.cell: it => {
    if it.y == 0 {
      set text(white)
      strong(it)
    } else {
      it
    }
  }

  table(
    columns: 5,
    [Droit], [Raccourci], [Octal], [Pour un fichier], [Pour un répertoire],
    [Lecture], [r (read)], [4], [Droit de lire le fichier.], [Droit de voir le contenu du répertoire (les fichiers et répertoires qu’il contient).],
    [Ecriture], [w (write)], [2], [Droit de modifier le fichier.], [Droit de modifier le contenu du répertoire (ajouter ou supprimer des fichiers et des répertoires à l’intérieur).],
    [Exécution], [x (execute)], [1], [Droit d’exécuter le fichier (programme).], [Droit de traverser le répertoire.],
  )
}
Pour chaque fichier et/ou répertoire, on définit pour le propriétaire, le groupe propriétaire et les autres une combinaison de ces trois droits.

Par exemple, on peut dire que le propriétaire a le droit d'exécuter, lire, et écrire (xrw ou 1+2+4=7), le groupe propriétaire a le droit d'exécuter et lire (xr- ou 1+2=3) et les autres n'ont que le droit de lire (-r- ou 2).


#pagebreak()


== Commandes utiles

=== `pwd` (où suis-je ?)

`pwd` ("print working directory") est une autre des commandes les plus simples sur Linux...

Tapez `pwd` dans votre shell, et la commande vous donnera... le chemin absolu du répertoire dans lequel vous vous trouvez.

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ pwd
/home/prof
```
 \
 \

=== `cd` (se déplacer)

`cd` ("change directory") permet de changer le répertoire de travail, le répertoire dans lequel vous êtes. \
Dit autrement, `cd` vous permet de vous déplacer dans l'arborescence de fichiers.

==== Manuel

```console
NOM
       cd - changer le répertoire de travail du shell.

SYNOPSIS
       cd [DIR]

Change le répertoire courant pour DIR.
Par défaut, DIR est le répertoire personnel de l'utilisateur.
Si DIR est "-", on retourne au répertoire précédent.
```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ cd /var/log
prof@ece-sys-vm:/var/log$ pwd
/var/log
prof@ece-sys-vm:/var/log$ cd ../lib
prof@ece-sys-vm:/var/lib$ pwd
/var/lib
prof@ece-sys-vm:/var/lib$ cd grub
prof@ece-sys-vm:/var/lib/grub$ pwd
/var/lib/grub
prof@ece-sys-vm:/var/lib/grub$ cd
prof@ece-sys-vm:~$ pwd
/home/prof
```

#pagebreak()

=== `ls` (lister le contenu d'un répertoire)

`ls` permet de lister le contenu d'un répertoire.

==== Manuel

```console
NOM
       ls - Afficher le contenu de répertoires

SYNOPSIS
       ls [OPTION]... [FICHIER]...

DESCRIPTION
       Afficher  les  informations  des FICHIERs (du répertoire courant par
       défaut). Les entrées sont triées alphabétiquement si aucune des  op‐
       tions -cftuvSUX ou --sort n'est indiquée.

       Les paramètres obligatoires pour les options de forme longue le sont
       aussi pour les options de forme courte.

       -a, --all
              inclure les entrées débutant par « . »
       -A, --almost-all
              omettre les fichiers « . » et « .. »
       -c     avec  -lt, trier selon « ctime » (date de la dernière modifi‐
              cation d'état du fichier) en l'affichant ; avec -l, trier se‐
              lon le nom et afficher la date de modification ; sinon, trier
              selon la date de modification, de la plus récente à  la  plus
              ancienne
       -h, --human-readable
              avec  -l  ou  -s, afficher les tailles en format lisible (par
              exemple 1K, 234M, 2G, etc.)
       -l     utiliser un format d'affichage long
       -n, --numeric-uid-gid
              identique  à  -l mais en affichant les valeurs numériques des
              identifiants du propriétaire (UID) et du groupe (GID)
       -R, --recursive
              afficher récursivement les sous-répertoires
̀```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ ls
workdir
prof@ece-sys-vm:~$ ls workdir
scriptreplay_ng
prof@ece-sys-vm:~$ ls workdir/scriptreplay_ng/ -la
total 32
drwxrwxr-x 4 prof prof 4096 déc.  27 16:03 .
drwxrwxr-x 3 prof prof 4096 janv. 25 21:57 ..
drwxrwxr-x 2 prof prof 4096 déc.  27 16:03 example
-rw-rw-r-- 1 prof prof  157 déc.  27 16:03 .gitignore
-rw-r----- 1 prof adm  4285 déc.  27 16:03 README.md
-rwxr-x--- 1 prof adm   305 déc.  27 16:03 record-script-session
̀```

Le répertoire  `workdir/scriptreplay_ng/` appartient à l'utilisateur `prof`. \ 
Il a le droit de le traverser, d'en lire le contenu et d'écrire à l'intérieur. \ 
Son groupe propriétaire est `prof`, les membres de ce groupe ont le droit de le traverser, d'en lire le contenu et d'écrire à l'intérieur. \ 
Tous les autres utilisateurs de la machine ont le droit de le traverser et d'en lire le contenu.

Le répertoire  `workdir/` a exactement les mêmes caractéristiques.

Le fichier  `workdir/scriptreplay_ng/README.md` appartient à l'utilisateur `prof`. \ 
Il a le droit de le lire et de le modifier. \ 
Son groupe propriétaire est `adm`, les membres de ce groupe ont le droit de le lire. \
Tous les autres utilisateurs de la machine n'ont aucun droit dessus.

Le fichier  `workdir/scriptreplay_ng/record-script-session` appartient à l'utilisateur `prof`. \ 
Il a le droit de l'exécuter, de le lire et de le modifier. \ 
Son groupe propriétaire est `adm`, les membres de ce groupe ont le droit de l'exécuter et de le lire. \
Tous les autres utilisateurs de la machine n'ont aucun droit dessus.


#pagebreak()

=== `mkdir` (créer des répertoires)

`mkdir` ("make directory") permet de créer des répertoires.

==== Manuel

```console
NOM
       mkdir - Créer des répertoires

SYNOPSIS
       mkdir [OPTION]... RÉPERTOIRE...

DESCRIPTION
       Créer les RÉPERTOIREs s'ils n'existent pas.

       Les  paramètres  obligatoires pour les options de forme longue le
       sont aussi pour les options de forme courte.

       -m, --mode=MODE
              utiliser le mode du fichier (comme avec « chmod »), et non
              au format umask (a=rw)
       -p, --parents
              pas d'erreur s'il existe, créer  des  répertoires  parents
              comme  il  faut,  avec des noms de fichier non touchés par
              l'option -m.
̀```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ mkdir rep
prof@ece-sys-vm:~$ mkdir -p rep/sous-rep/sous-sous-rep
prof@ece-sys-vm:~$ ls -R rep/
rep/:
sous-rep

rep/sous-rep:
sous-sous-rep

rep/sous-rep/sous-sous-rep:
̀```

#pagebreak()

=== `rm` (supprimer des fichiers ou des répertoires)

`rm` ("remove") permet de supprimer des fichiers ou des répertoires.

==== Manuel

```console
NOM
       rm - Effacer des fichiers et des répertoires

SYNOPSIS
       rm [OPTION]... [FICHIER]...

DESCRIPTION
       Le programme rm  efface  chaque fichier listé. Par défaut,
       il n'efface pas les répertoires.

OPTIONS
       Supprimer le ou les FICHIERs.

       -f, --force
              ignorer les fichiers et paramètres inexistants, ne pas de‐
              mander de confirmation
       -i     demander une confirmation avant chaque effacement
       -I     demander une fois avant d'effacer plus de trois  fichiers,
              ou  pour  les  effacements récursifs. C'est moins intrusif
              que -i, mais protège tout de même de la  plupart  des  er‐
              reurs
       -r, -R, --recursive
              enlever le contenu des répertoires récursivement
       -d, --dir
              supprimer des répertoires vides

       Par défaut, rm n'efface pas les  répertoires.  Utilisez  l'option
       --recursive  (-r  ou  -R) pour effacer chaque répertoire passé en
       paramètre en même temps que son contenu.
̀```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ ls
fichier  rep  workdir
prof@ece-sys-vm:~$ rm fichier 
prof@ece-sys-vm:~$ rm -r rep/
prof@ece-sys-vm:~$ ls
workdir
̀```

#pagebreak()

=== `cp` (copier des fichiers ou des répertoires)

`cp` ("copy") permet de copier des fichiers ou des répertoires.

==== Manuel

```console
NOM
       cp - Copier des fichiers et des répertoires

SYNOPSIS
       cp [OPTION]... [-T] SOURCE CIBLE
       cp [OPTION]... SOURCE... RÉPERTOIRE

DESCRIPTION
       Copier  la SOURCE vers la CIBLE, ou plusieurs SOURCEs vers le RÉ‐
       PERTOIRE.

       Les paramètres obligatoires pour les options de forme  longue  le
       sont aussi pour les options de forme courte.

       -a, --archive
              identique à -dR --preserve=all
       -f, --force
              si  un  fichier  cible  existant  ne peut pas être ouvert,
              alors le détruire et essayer à nouveau (cette  option  est
              ignorée si -n est aussi utilisé)
       -i, --interactive
              demander  confirmation  avant d'écraser (annule une précé‐
              dente option -n)
       -p     identique à --preserve=mode,ownership,timestamps
       --preserve[=LISTE_ATTR]
              préserver les attributs indiqués
       --no-preserve=LISTE_ATTR
              ne pas préserver les attributs indiqués
       -R, -r, --recursive
              copier récursivement les répertoires
       -T, --no-target-directory
              traiter la CIBLE comme un fichier normal
̀```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ ls
fichier1  workdir
prof@ece-sys-vm:~$ ls workdir/

prof@ece-sys-vm:~$ cp fichier1 fichier2
prof@ece-sys-vm:~$ ls
fichier1  fichier2  workdir
prof@ece-sys-vm:~$ cp fichier1 fichier2 workdir/
prof@ece-sys-vm:~$ ls workdir/
fichier1  fichier2  scriptreplay_ng
̀```


#pagebreak()

=== `mv` (déplacer des fichiers ou des répertoires)

`mv` ("move") permet de déplacer des fichiers ou des répertoires. \
On peut aussi l'utiliser pour renommer un fichier ou un répertoire.

==== Manuel

```console
NOM
       mv - Déplacer ou renommer des fichiers

SYNOPSIS
       mv [OPTION]... [-T] SOURCE CIBLE
       mv [OPTION]... SOURCE... RÉPERTOIRE

DESCRIPTION
       Renommer  la SOURCE en CIBLE ou déplacer la SOURCE vers le RÉPER‐
       TOIRE.

       Les paramètres obligatoires pour les options de forme  longue  le
       sont aussi pour les options de forme courte.

       -f, --force
              ne pas demander de confirmation avant d'écraser
       -T, --no-target-directory
              traiter la CIBLE comme un fichier normal
̀```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ ls
fichier1  fichier2  workdir
prof@ece-sys-vm:~$ mkdir newdir
prof@ece-sys-vm:~$ mv fichier2 fichier-2
prof@ece-sys-vm:~$ ls
fichier1  fichier-2  newdir  workdir
prof@ece-sys-vm:~$ mv fichier1 fichier-2 newdir/
prof@ece-sys-vm:~$ ls
newdir  workdir
prof@ece-sys-vm:~$ ls newdir/
fichier1  fichier-2
̀```


#pagebreak()

=== `cat` (afficher le contenu d'un fichier)

`cat` permet de concaténer le contenu de fichier(s) dans la sortie de la console.

==== Manuel

```console
NOM
       cat - Concaténer des fichiers et les afficher sur la sortie stan‐
       dard

SYNOPSIS
       cat [OPTION] ... [FICHIER] ...

DESCRIPTION
       Concaténer le ou les FICHIER(s) sur la sortie standard.

       L'entrée standard est lue quand FICHIER est omis ou quand FICHIER
       vaut « - ».

       -b, --number-nonblank
              numéroter les lignes non vides, annule -n
       -n, --number
              numéroter toutes les lignes
       -s, --squeeze-blank
              supprimer les lignes vides répétées
̀```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ cat fichier1
Ceci est le contenu du fichier 1.
prof@ece-sys-vm:~$ cat fichier1 fichier2
Ceci est le contenu du fichier 1.
Ceci est le contenu du fichier 2
̀```



#pagebreak()

=== `touch` (mettre à jour un fichier)

`touch` permet de mettre à jour la date de dernière modification et de dernier accès à un fichier, *en le créant s'il n'existe pas*.

==== Manuel

```console
NAME
       touch - change file timestamps

SYNOPSIS
       touch [OPTION]... FILE...

DESCRIPTION
       Update the access and modification times of each FILE to the cur‐
       rent time.

       A  FILE  argument that does not exist is created empty, unless -c
       or -h is supplied.

       Mandatory arguments to long options are mandatory for  short  op‐
       tions too.

       -a     change only the access time
       -c, --no-create
              do not create any files
       -m     change only the modification time
       -r, --reference=FILE
              use this file's times instead of current time
̀```

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ ls -l
total 16
-rw-rw-r-- 1 prof prof   34 janv. 25 22:36 fichier1
-rw-rw-r-- 1 prof prof   33 janv. 25 22:36 fichier2
prof@ece-sys-vm:~$ touch fichier1
prof@ece-sys-vm:~$ ls -l
total 16
-rw-rw-r-- 1 prof prof   34 janv. 25 22:41 fichier1
-rw-rw-r-- 1 prof prof   33 janv. 25 22:36 fichier2
prof@ece-sys-vm:~$ touch fichier3
prof@ece-sys-vm:~$ ls -l
total 16
-rw-rw-r-- 1 prof prof   34 janv. 25 22:41 fichier1
-rw-rw-r-- 1 prof prof   33 janv. 25 22:36 fichier2
-rw-rw-r-- 1 prof prof    0 janv. 25 22:42 fichier3
̀```


#pagebreak()


=== `nano` (éditer un fichier)

`nano` est l'équivalent du bloc-notes.

Il est beaucoup plus simple à utiliser (mais beaucoup moins puissant) que `vim` ou `emacs`.

==== Manuel

```console
NOM
       nano - NAno un NOuvel éditeur, inspiré de Pico

SYNOPSIS
       nano [options] [[+ligne[,colonne]] fichier]...

DESCRIPTION
       nano  est  un  éditeur  léger  et facile. Il imite l'aspect et la
       convivialité de Pico, mais c'est un logiciel libre qui implémente
       plusieurs fonctionnalités qui manquent à Pico telles que l'ouver‐
       ture de plusieurs fichiers, le défilement  ligne  par  ligne,  la
       fonction annuler et refaire, la coloration syntaxique, la numéro‐
       tation des lignes et le pliage des lignes trop longues.

ÉDITION
       Entrer du texte et se déplacer dans un fichier est simple : taper
       les  lettres  et  utiliser les touches normales de déplacement du
       curseur. Les commandes sont  entrées  en  utilisant  les  touches
       Contrôle  (^), Alt ou Méta (M-). Frapper ^K détruit la ligne cou‐
       rante et la place dans le presse-papier. Les frappes consécutives
       de ^K placeront toutes les lignes supprimées dans  le  presse-pa‐
       pier. Tout mouvement du curseur ou exécution d'une autre commande
       fera  que  la  frappe  ^K  suivante écrasera le presse-papier. La
       frappe de ^U copiera le contenu du presse-papier à la  place  ac‐
       tuelle du curseur.

       Sur  certains  terminaux, le texte peut être aussi sélectionné en
       maintenant la touche Shift appuyée et en utilisant les flèches de
       direction. Maintenir appuyées également les touches Ctrl  ou  Alt
       augmentera le pas de la sélection. Tout mouvement du curseur sans
       l'appui sur la touche Shift annulera la sélection.

       Les deux lignes en bas de l'écran montrent quelques commandes im‐
       portantes :  le message d'aide de nano (^G) liste toutes les com‐
       mandes disponibles. Les raccourcis  clavier  par  défaut  peuvent
       être modifiés avec le fichier nanorc
̀```


=== `grep` (rechercher dans un fichier)

`grep` permet de rechercher un motif dans un fichier, ou dans la sortie d'une commande.

=== `more` (lire un fichier en mode paginé)

`more` permet de lire un fichier en mode paginé. C'est à dire qu'on affiche le fichier (en commençant par son début) par blocs tenant à l'écran. On peut ensuite faire défiler le contenu.


=== `head` (lire le début d'un fichier)

`head` permet de lire le début d'un fichier.

==== Manuel

```console
NOM
       head - Afficher le début des fichiers

SYNOPSIS
       head [OPTION]... [FICHIER]...

DESCRIPTION
       Afficher  les 10 premières lignes de chaque FICHIER sur la sortie
       standard. Avec plus d'un  FICHIER,  faire  précéder  chacun  d'un
       en-tête donnant le nom du fichier.

       L'entrée standard est lue quand FICHIER est omis ou quand FICHIER
       vaut « - ».

       Les  paramètres  obligatoires pour les options de forme longue le
       sont aussi pour les options de forme courte.

       -c, --bytes=[-]N
              afficher les N premiers octets de chaque fichier ; avec le
              préfixe « - », afficher tous les octets sauf  les  N  der‐
              niers octets de chaque fichier
       -n, --lines=[-]N
              afficher les N premières lignes au lieu des 10 premières ;
              avec le préfixe « - », afficher toutes les lignes sauf les
              N dernières lignes de chaque fichier
```



=== `tail` (lire la fin d'un fichier)

`tail` permet de lire la fin d'un fichier.

==== Manuel

```console
NOM
       tail - Afficher la dernière partie de fichiers

SYNOPSIS
       tail [OPTION] ... [FICHIER] ...

DESCRIPTION
       Afficher  les 10 dernières lignes de chaque FICHIER sur la sortie
       standard. Lorsqu'il y a plus d'un FICHIER, faire précéder  chaque
       groupe de lignes d'un en-tête donnant le nom du fichier.

       L'entrée standard est lue quand FICHIER est omis ou quand FICHIER
       vaut « - ».

       Les  paramètres  obligatoires pour les options de forme longue le
       sont aussi pour les options de forme courte.

       -c, --bytes=[+]N
              Afficher les N derniers octets ; vous pouvez aussi  utili‐
              ser  -c +N  pour  afficher  les octets de chaque fichier à
              partir du Nième octet
       -f, --follow[={name|descriptor}]
              Afficher les données ajoutées lorsque le fichier grossit ;

              l’absence d’argument d'option équivaut à  utiliser  « des‐
              criptor »
       -n, --lines=[+]N
              output  the last NUM lines, instead of the last 10; or use
              -n +NUM to skip NUM-1 lines at the start
```



#pagebreak()


#bibliography("./bib.yml", style: "ieee", full: true)