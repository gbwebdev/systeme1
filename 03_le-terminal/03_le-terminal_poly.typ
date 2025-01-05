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

Un shell, affiché dans un terminal, ressemble à ça :
#align(
  center,
  image("./illustrations/03_shell.png", width: 17cm)
)


#pagebreak()


#bibliography("./bib.yml", style: "ieee", full: true)