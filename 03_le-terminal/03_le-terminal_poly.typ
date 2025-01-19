#import "@local/it-course:0.1.0" : *
#import "@preview/sourcerer:0.2.1": code

#show: chapter.with(
  subject: "Système 1",
  subject-subtitle: "Découverte de linux",
  topic: "Chapitre 3",
  subtitle: "Le terminal",
  illustration: image("./couverture.png", width: 14cm),
  author: "Guillaume BITON",
  credit: "Droits d'exploitations accordés à l'ECE",
  licence: [Ce document est protégé par la licence CC BY-NC 4.0 https://creativecommons.org/licenses/by-nc/4.0/)],
  version: "1.0",
  lang: "fr",
  logo: image("../.assets/gbweb-ece.png", width: 9cm)
)

#heading(level: 1, numbering: none)[INTRODUCTION]

Dans ce chapitre, nous allons *enfin* entrer dans le vif du sujet et découvrir le *Terminal*, un outil qui peut sembler rustique au premier abord, mais qui s'avère d'une puissance phénoménale.
#pagebreak()

= Définition & historique

== Terminal
Le terminal est un dispositif capable d'afficher du texte, et dans lequel on peut saisir du texte.

Les premiers terminaux étaient des "téléscripteurs" ("teleprinter") qui imprimaient le résultat des commandes au fur et à mesure :
#align(
  center,
  figure(
    image("./illustrations/01_IBM-360-teleprinter.jpg", width: 8cm),
    caption: [Terminal/telescripteur des IBM 360],
  )
)

Puis, les terminaux dotés d'écrans cathodiques de 24 lignes et 80 colonnes :
#align(
  center,
  figure(
    image("./illustrations/02_terminal.png", width: 8cm),
    caption: [Un terminal DEC VT100, l'un des plus utilisés dans le monde],
  )
)

#info()[
  On a tendance à partler de "console" pour dire "terminal" : nous retiendrons qu'il s'agit de la même chose.
]

On peut voir un terminal comme un "ordinateur" qui ne dispose pas (ou alors de très peu) de CPU et de mémoire. On s'en sert pour piloter un ordinateur distant. Aujourd'hui, on utilise le plus souvent des "émulateurs de terminaux" qui sont des programmes graphiques qui fournissent une interface de type terminal pour se connecter au shell d'une machine locale (le PC sur lequel il tourne) ou distant (un ordinateur dans une autre pièce, un serveur à l'autre bout de la planète...) via le réseau.
Mais il existe toujours des terminaux "physiques", c'est par exemple ce dont sont souvent équipées les caisses des magasins.

#info()[
  Au paragraphe précédent, j'ai utilisé le terme "shell". Le shell est un programme permettant de communiquer avec l'ordinateur. Il permet de saisir des commandes (sous forme de texte) et affiche le résultat (sous forme de texte). \
  Le shell est le programme avec lequel on interagit lorsqu'on utilise un terminal (ou un émulateur de terminal).
]

#info()[
  Linux étant multiutilisateur et multitache, on peut parfaitement l'utiliser à plusieurs en même temps via plusieurs terminaux.
]

== Shell

Un shell, affiché dans un terminal, ressemble à ça :
#align(
  center,
  image("./illustrations/03_shell.png", width: 17cm)
) <shell>

#info()[
  Il est très possible que vous soyez en train de vous demander qui de sain d’esprit voudrait se servir d’un truc comme ça quand on dispose d’interfaces graphiques… \
  Et bien sachez que des millions de gens se servent quotidiennement du terminal (j’y passe moi même au moins 8h par jour) et qu’ils ne l’échangeraient pour rien au monde. \
  Ces gens ne sont pourtant ni masochistes, ni snobs… \
  Le terminal est simplement le moyen le plus efficace et le plus simple (si, si !) d’effectuer un très grand nombre de tâches sur sa machine.
]

Sur la #link(<shell>)[capture d'écran ci-dessus], il se passe énormément de choses :
- Le shell nous informe que nous sommes sur une distribution Linux "Ubuntu" en version 22.04.3 (Long Term Support). La machine s'appelle "Lubuntu-VM" et nous sommes sur le 3ème terminal virtuel (tty3).
- Il nous demande de nous identifier : je lui dis que je suis l'utilisateur "guillaume"
- Il nous demande notre mot de passe (notez que Linux n'affiche jamais le mot de passe, ni même le nombre de caractères)
- Il nous souhaite la bienvenue en nous rappelant la distribution, la version, et en précisant la version du Noyau (kernel) utilisé et l'architecture du CPU (x86_64).
- Il nous dit que la dernière fois que je me suis connecté, c'était le Dimanche 15 Octobre à 22h26 (heure d'été d'europe centrale) en utilisant le le 2ème terminal virtuel (tty2)
- Il m'invinte à saisir une commande via le #link(<prompt>)["prompt"] (#link(<prompt>)[on y reviendra]) : je lui demande d'écrire "Hello World !"
- Il s'exécute (il écrit "Hello World !")
- Il m'invinte à saisir une commande via le #link(<prompt>)["prompt"]
- ...

A l'origine, le premier Unix proposait le "Thompson shell" (du nom de son créateur, Ken Thompson). \
Dès sa version 7, Unix intègre le "Bourne Shell" (créé par Stephen Bourne). \
Il est encore très utilisé aujourd'hui (on l'appelle souven "sh" du nom de la commande qu'il faut taper pour l'appeler).

En 1988, "bash" ("Bourne Again Shell", soit "Encore un Bourne Shell", ce qui sonne comme "Born Again Shell" soit "Shell réincarné") est développé pour GNU par la Free Software Foundation. \
C'est le shell par défaut sur bien des distributions Linux et, de fait sans doute le shell le plus utilisé dans le monde.


== Prompt

Le "prompt" (ou "invite de commande") nous indique que le shell attend qu'on tape une commande.
Il le fait généralement en affichant un message formaté de manière très précise, pour nous donner quelques informations sur le contexte.
Par défaut, Bash, affiche un prompt de cette forme :
#align(
  center,
  image("./illustrations/04_prompt.png", width: 12cm)
) <prompt>

Le prompt se termine presque toujours par un dollar (`$`) quand on est un utilisateur "lambda" ou un dièse (`#`) quand on est un super utilisateur.

On tape une commande dans le prompt, et on valide en pressant "entrée". Shell interprète la commande et nous affiche le résultat :
#code(
  lang: "bash",
  ```sh
  guillaume@Lubuntu-VM:~$ date
  sam. 21 oct. 2023 19:37:56 CEST
  ```)
On a demandé à shell d'afficher la date, ce qu'il a fait.

#pagebreak()
= Exemples

Ce n'est pas parce que le terminal ne fonctionne qu'en mode texte qu'il ne peut pas afficher des informations mises en formes.
Par exemple, la commande `cal` permet d'afficher un calendrier :
#code(
  lang: "bash",
  ```bash
  guillaume@Lubuntu-VM:~$ cal -A 1 -B 1
    Septembre 2023            Octobre 2023             Novembre 2023      
  di lu ma me je ve sa     di lu ma me je ve sa      di lu ma me je ve sa  
                  1  2      1  2  3  4  5  6  7                1  2  3  4  
  3  4  5  6  7  8  9      8  9 10 11 12 13 14       5  6  7  8  9 10 11  
  10 11 12 13 14 15 16     15 16 17 18 19 20 21      12 13 14 15 16 17 18  
  17 18 19 20 21 22 23     22 23 24 25 26 27 28      19 20 21 22 23 24 25  
  24 25 26 27 28 29 30     29 30 31                  26 27 28 29 30 
  ```)

La commande `htop` permet d'afficher l'utilisation des ressources système :
#align(
  center,
  image("./illustrations/05_htop.png", width: 14cm)
)

#pagebreak()
= Syntaxe des commandes

La norme veut qu'on écrive toujours :
```
commande arguments
```

Commande est le nom de la commande. Elle peut être suivie d'un ou de plusieurs arguments.

On distingue les arguments optionnels (on les appelle "options") des arguments dits "positionnels". Les options peuvent elles-même avoir des arguments.

== Arguments optionnels (options)

Les arguments optionnels sont généralement marqués par des tirets ("-").

Les options ont toujours une forme longue, marquée par un double tiret  "`--`" (par exemple "`--help`" ou "`--preserve-permissions`") et peuvent avoir une forme raccourcie, marquée par un tiret simple "`-`" (par exemple "`-h`" ou "`-p`").

On peut mettre plusieurs options courtes à la suite. Par exemple "`-abc`" équivaut à "`-a -b -c`".

== Argument positionnel d'argument optionnel
Un argument optionnel peut lui-même attendre un argument positionnel. Cet argument devra alors le suivre directement.

Par exemple, dans l'aide de la commande "`tar`", on trouve :

#code(
  lang: "bash",
  ```sh
  Utilisation : tar [OPTION...] [FICHIER]...

  Examples:
  tar -xf archive.tar          # Extract all files from archive.tar.

  [...]

    -f, --file=ARCHIVE         Utiliser le fichier ou le périphérique ARCHIVE
  ```)

On voit que l'option "`-f`" ou "`--file`" attend un argument qui est le nom du fichier d'archive.

Donc on doit écrire : \
`tar -xf archive.tar`


Si on essaie d'écrire :\
`tar -fx archive.tar`\
Cela ne fonctionnera pas.


== Arguments positionnels

Les arguments positionnels sont tout simplement des arguments dont le role est défini par son positionnement dans la commande.

Par exemple, la commande cp a pour synopsys "cp SOURCE DESTINATION". Donc le premier argument représentera toujours la source et le second la destination.


#pagebreak()
= Utiliser la documentation (RTFM)

La première commande à connaitre est "man", elle permet d'afficher le manuel d'une autre commande.\ 

L'option "`--help`" est une option très, très fréquemment implémentée dans les commandes Linux. Elle permet d'afficher une aide succinte pour la commande concernée.

Par exemple :
#code(
  lang: "bash",
  ```sh
  $ cp --help
  Utilisation : cp [OPTION]... [-T] SOURCE DEST
  Copier la SOURCE vers DEST.

  Les arguments obligatoires pour les options longues le sont aussi pour les
  options courtes.
    -a, --archive                identique à -dR --preserve=all
    -f, --force                  si un fichier de destination existe et ne peut
                                  être ouvert, alors le supprimer et réessayer
                                  (cette option est ignorée si l'option -n est
                                  aussi utilisée)
    -T, --no-target-directory    traiter DEST comme un fichier normal
  ```)

Ceci nous apprend que la commande `cp` peut être utilisée pour copier l'argument "SOURCE" vers l'argument "DESTINATION".
On peut également utiliser des options.
Par exemple, l'option `--force` (on peut aussi utiliser le raccourci `-f`) permet de forcer le remplacement de la destination.

On appelle "SYNOPSIS" la notation, ou la syntaxe de la commande.

La convention veut qu'on écrive :
- Entre crochets les éléments optionnels
- Séparé par des barres verticales ("|") les éléments substituables
- Suivi de points de suspensions ("...") les éléments qui peuvent être répétés

Par exemple :
#code(
  lang: "bash",
  ```sh
  $ man mkdir
  NAME
        mkdir - make directories

  SYNOPSIS
        mkdir [OPTION]... DIRECTORY...

  DESCRIPTION
        Create the DIRECTORY(ies), if they do not already exist.

       Mandatory arguments to long options are mandatory for short options too.

       -m, --mode=MODE
              set file mode (as in chmod), not a=rwx - umask

       -p, --parents
              no error if existing, make parent directories as needed, with their file modes unaffected by any -m option.
  ```)

Cela nous apprend que la commande `mkdir` est utilisée pour créer des répertoires s'ils n'existent pas déjà.

Pour l'utiliser, on écrit "mkdir", à la suite de quoi on peut écrire des options (par exemple `-p` si on veut créer les répertoires parents) et enfin au moins un nom de répertoire qu'on veut créer, et possiblement plusieurs.


#code(
  lang: "bash",
  ```sh
  $ man ls
  NAME
        ls - list directory contents

  SYNOPSIS
        ls [OPTION]... [FILE]...

  DESCRIPTION
        List  information  about  the FILEs (the current directory by default).  Sort entries alphabetically if none of -cftuvSUX nor --sort is speci‐
        fied.

        Mandatory arguments to long options are mandatory for short options too.

        -a, --all
                do not ignore entries starting with .
  ```)

Cela nous apprend que la commande ls permet de lister le contenu d'un répertoire.

Pour l'utiliser, on écrit "ls". On peut ensuite mettre une ou des options si on le souhaite. Et enfin on peut mettre un ou des chemin de fichiers/répertoires dont on veut lister le contenu. Si on ne met pas de chemin de fichier/répertoire, le répertoire dans lequel on se trouve actuellement sera utilisé.


#pagebreak()


#bibliography("./bib.yml", style: "ieee", full: true)