#import "@local/it-course:0.1.0" : *
#import "@preview/sourcerer:0.2.1": code


#show: chapter.with(
  subject: "Système 1",
  topic: "Démo typst",
  subtitle: "Démonstration des capacités de typst",
  illustration: image("./chapitre1_couverture.png", width: 15cm),
  author: "Guillaume BITON",
  version: "1.0",
  lang: "fr"
)

#heading(level: 1, numbering: none)[INTRODUCTION]


= PREMIERE PARTIE
== Sous-partie 1
=== Sous-sous partie 1
==== Sous-sous-sous partie

Paragraphe, *texte en gras*, `code 0`.

- List 1
- List 2

```console
guillaume@LP-Guillaume:~/Documents/ECE/Système 1$ cat /etc/hosts
127.0.0.1 localhost
127.0.1.1 LP-Guillaume

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

#code(
  lang: "bash",
  ```sh
  echo 'Bonjour'
  ls -la
  ```)

#code(
  lang: "JSON",
```json
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 250
}
```)

[Lien internet](www.google.com)


=== Sous-sous partie 2
= Deuxième partie


#warning()[
        = tutu
        == titre
        Ceci est un warning !
        - bullet 1
        - bullet
]

#idea()[
        == titre
        Ceci est une idée !!!
]

#info()[
        == titre
        Ceci est une info !
]

#wrong()[
        == titre
        Ceci est faux !! !
]

#good()[
        == titre
        Ceci est tout bon !
]

#learn()[
        == titre
        Ceci est à apprendre par coeur !
]

#light-learn()[
        == titre
        Ceci est à apprendre par coeur !
]



#let citation_style = (
  entry => {
    
    let flags = (
        "fr-FR": "FRENCH",
        "en-UK": "ENGLISH",
        "en-US": "ENGLISH"
    )
    // Format the citation with the flag and language
    text(entry.authors + " - " + entry.title + " [" + flags.at(entry.language) + "]")
  }
)

#let appro(bibref) = {
  for (key, value) in bibref [
    #let flag = {box(
        height: 11pt,
        baseline: 20%,
        image("./illustrations/" + value.language + ".svg")
        )
    }
      - #value.title   #flag
  ]
}

#appro(yaml("./bib.yml"))

