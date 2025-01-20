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

Les comptes utilisateurs servent notemment à mettre en oeuvre des politiques de permissions (qui a le droit de faire quoi et d'accéder à quoi sur le système) et à la traçabilité des opérations effectuées sur le système (on parle d'_audit logs_ : qui a fait quoi, et quand).

#warning()[
  Les comptes utilisateurs jouent donc un rôle très important dans la sécurisation des systèmes, et ont une valeur *juridique* : si une action illégale, malveillante et/ou une erreur professionnelle a été effectuée avec votre compte, vous en êtes responsable auprès du propriétaire du système (souvent votre employeur) et/ou aux yeux de la loi. Si vous n'êtes pas l'auteur de ces actions, on considerera que vous êtes à minima responsable de ne pas avoir suffisemment protégé votre mot de passe, ou de l'avoir volontairement donné à quelqu'un de malveillant, ce qui vaut complicité.

  Votre compte utilisateur et votre mot de passe sont donc *précieux* et représentent votre *identité* sur le système.
]


Il existe des comptes utilisateurs qui ne représentent pas des humains mais des programmes, ou même des abstractions du système d'exploitation, on les appelle les *comptes systèmes*.

Linux propose également une notion de *groupes utilisateurs*.\
Les groupes utilisateurs permettent de représenter un ensemble d'utilisateurs et sont principalement utilisés dans la mise en oeuvre des politiques de permissions (qui a le droit de faire quoi et d'accéder à quoi sur le système).\
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
  - accéder à *tous* les fichiers du systèmes, quelque soient leurs permissions
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

Dans un shell moderne avec un prompt "classique" cela n'a pas un grand intéret (le prompt vous rappelle votre nom d'utilisateur à chaque fois), mais cela peut être utile quand :
- vous écrierez des scripts
- vous utiliserez des systèmes où vous êtes contraints d'utiliser des shells plus "rustiques"

==== Exemple d'utilisation

```console
prof@ece-sys-vm:~$ whoami
prof
```



=== `id` (identifiants)

`id` permet d'obtenir l'UID, le GID ainsi que les IDs de tous les groupes auquels un utilisateur appartient.

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
Si on n'en précise pas, ce sera pour l'utilisateur qui éxécute la commande.

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

Dans Linux, on range les fichiers dans des répertoires, que l’on peut eux même mettre dans des répertoires etc…

Chaque fichier, et chaque répertoire ont un chemin d’accès. \
On sépare les noms des fichiers et des répertoires par des slash (« / »). \
La base du système de fichiers est appelée la « racine », en anglais « root ».

#warning()[
  == Ne pas confondre :
  - L’utilisateur « `root` » qui est le super-utilisateur (UID 0)
  - Son répertoire personnel dont le chemin est « `/root` »
  - La racine du système de fichiers que l’on appelle « root » et dont le chemin est « `/` »
]


Le système de fichiers de Linux forme ce que l'on appelle une "arborescence" : elle peut être représentée sous la forme d'un arbre. \
Cette arbre n'a qu'un seul et unique tronc (que l'on appelle étrangement "racine" ou, en anglais `root`). De ce tronc partent des branches (les répertoires). Chaque branche peut supporter :
- d'autres branches
- des feuilles (les fichiers)

#align(
  center,
  image("./illustrations/arborescence1.png", width: 11cm)
)

Vous en conviendrez, cette représentation n'est pas très pratique.\ 
On en préfère donc une qui ressemble un peu moins à un arbre, mais beaucoup plus lisible :
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


#pagebreak()


#bibliography("./bib.yml", style: "ieee", full: true)