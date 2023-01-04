# Deprecation note

Traité is not going to be maintained or fixed anymore, since Silicon Tabula is
slowly moving to the Hugo framework with a set of configuration also called
``traite``.  
So, this repository is going to be archived and renamed as ``traite.old``.  
However, feel free to fork and continue the work, it's open! :^)

![](img/logo.png) 

## What is it?

Traité de la *tabula* (a.k.a "``traite``" as its command-line name) is a static
documentation generator written purely in Korn Shell --- more specifically,
[KSH-93](http://www.kornshell.com/doc/ksh93.html). It uses
[Pandoc](https://pandoc.org) for converting from Markdown to HTML and,
indirectly, [XeTeX](https://tug.org/xetex/) as the default (La)TeX engine.  

### Why is the name in French?

The name originates from the optics book "*Traité de la lumière: Où Sont
Expliquées les Causes de ce qui Luy Arrive Dans la Reflexion & Dans la
Refraction*" (or, in short, "*Traité de la lumière*"), written by the Dutch
polymath Christiaan Huygens and published in 1690 in the French language.
Summarizing it --- since I could not in fact read it by its completness yet ---,
it introduces and elaborates Huygens' views on light, its nature and behavior.  
I had contact with it when I was in my High School junior year, making a Physics
coursework on light and telescopes (called "*Como a óptica influenciou a ciência:
o telescópio*"), and, although I did not had time to really read and dig deeper on
it, it marked me in some way at the time --- along with Isaac Newton's "*Optica*"
--- mostly because of the fact that it was written at the Enlightenment period
than of the contribution that it has done to the optics.

"*tabula*" is the name given for documents written for the Pindorama project,
served at the Silicon Tabula (``silicon.pindorama.dob.jp``). The Silicon Tabula
is a compilation of all the other *tabulas* written in the project.  
"*tabula*" means "tablet" in Latin; it came from "*Tabula Smaragdina*", which
served as inspiration for the 1974 album "*A Tábua de Esmeralda*" by the
Brazilian composer and singer Jorge Ben Jor, which then served as inspiration
for me, when I was studying for creating
[Copacabana](http://copacabana.pindorama.dob.jp) Linux® in 2021. So, since I was
wanting to make a tribute to Jorge Ben's work --- and, consenquently, to the
original *Tabula Smaragdina* --- I decided to call Pindorama's documentation of
"*tabula*" instead of "docs", "wiki" or anything else.  

Since this program builds the *tabulas* from Markdown to a stylized HTML with
pre-defined defaults for things such as theming, I decided to call it "Traité de
la *tabula*" because it is, in fact, a "treaty", that defines rules for how
everything shall looks like, where it shall be stored *et cetera*.  

## How it works?

The simple diagram below explains how this program works (click on it to see it
larger and with colours (92.0K)).  
|[![](img/how_it_works_diagram.dithered.png)](img/how_it_works_diagram.png)|
|:--:|
| Captions:<br/>Blue arrows/lines: Information and or descriptions of what is being shown;<br/>Black arrows/lines: Flow of files/pipelines between parts of the program.|  

Traité works basically as a front-end for Pandoc, but adding some handy
--- but simple --- functionalities, such as configuration files for generating
HTML documents instead of running everything manually --- the so-called
``tabula.conf``.  

The ``tabula.conf`` file is present at the root of every *tabula*, it contains
basic metadata information and, the most important: a sorted (from the start to
the end of the document) array containing all the Markdown files that will be
compiled to a HTML.  

This is a very simple example:  
```sh
files=( prologue.md ch1.md ch2.md \
	ch3.md ch4.md ) 
```

In the case above, we will be compiling the files ``prologue.md``, ``ch1.md`` up
to ``ch4.md`` into a standalone HTML file, and it will have the final contents
sorted in the order provided --- if we mess up and put, hipotetically,
``ch2.md`` before ``ch1.md``, we will end up with the ``ch2.md`` contents before
``ch1.md``, so take care.

The other information is used for ``--metadata`` arguments at Pandoc and for
generating the HTML footer with ``sed`` later. You can read the code and see
where these information is used, if you have any questions about it.   

## Dependencies

* KSH-93;
* sed;
* Pandoc;
* XeTeX.

## Chip in!

If you are willing to contribute, by implementing a new feature, fixing bugs
or cleaning up the code, go ahead!  
We are open for pull-requests, as long it is useful for the project.  
Please, just note that we are using the [Conventional
Commits](http://conventionalcommits.org) specification, so try to keep your
commits under it. ``;^)``

### TODO

Currently, we are looking for these features:

* Multi-language/Translation support (maybe à lá MkDocs?);
* Safer (and possibly more complex) ``nuke`` function, that deals correctly with
  the new translation feature. 

### Hacking

Although Traité was made just in two days, its code is fairly readable even for
ones who does not actually code in Shell script. After around three years of
experience, I have been able to keep a consistent and sane code-style.  

Good references for learning Korn Shell are O'Reilly's "Learning the Korn Shell,
2nd Edition" and, for Portuguese speakers, "Programação Shell Linux" --- that
tries to cover all the UNIX shells and its differences, from GNU Broken-Again
Shell to even the (crappy) POSIX standard.  

"Learning the Korn Shell" is a paid book --- but I have heard it from the
grapevine that it can be found for free in some website from Ukraine, the domain
name rhymes with "milk".  
"Programação Shell Linux" is also a paid book --- but I also have heard that a
fairly older version, from around 2010, can also be found in some website whose
name rhymes with "doceiro" (a Portuguese word for "confectioner").

### Other projects intrinsically related to TDLT that you may want to chip in (just in case you do not hack with Shell)

* [Silicon Tabula](https://github.com/Projeto-Pindorama/Silicon-Tabula) - All
  the Pindorama project *tabulas* (documentation), compiled in one repository;
* [acme4real](https://github.com/takusuman/acme4real#screenshots-pandoc-port) -
A Vim colorscheme heavly inspired by ``acme``(1) by Rob Pike, but with actual
syntax highlighting (Pandoc port);
* [Pandoc Goodies](https://github.com/tajmone/pandoc-goodies) - A teasure-box of
  resources for Pandoc, PP and Texts word processor;
* [Pandoc](https://pandoc.org) - A universal document converter;
* [XeTeX](http://xetex.sourceforge.net) - Unicode-based TEX;
* [ksh93](http://www.kornshell.com) - The KornShell Command And Programming
Language.

## Who can I blame for it?

Me, who speaks to you, Luiz Antônio (a.k.a ``takusuman``).

## Licence

Everything is licenced under the MIT licence, with an exception to the files at
the ``boilerplate/`` directory, which are licenced under Public Domain.  
