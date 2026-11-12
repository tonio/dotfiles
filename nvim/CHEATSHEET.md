# Neovim cheat-sheet

Leader : `,` · Neovim 0.12 · LSP natif, blink.cmp, Telescope

## Mappings perso

| Touche | Action |
|---|---|
| `gq` (insert) | Échap |
| `<Esc>` (terminal) | Repasser en mode normal |
| `é` / `è` | Onglet précédent / suivant |
| `Espace` | Fenêtre suivante |
| `,r` | `:e!` (recharger le fichier) |
| `,ew` `,es` `,ev` `,et` | Ouvrir depuis le dossier courant : ici / split / vsplit / onglet |
| `,<Espace>` | Effacer le surlignage (recherche et mots) |
| `,d` | Aller au tag (`<C-]>`) |
| `,:` `,=` | Tabularize sur `:` / `=` |
| `,o` | Tabularize `:` dans le `{}` courant |
| `,é` | Entourer le mot (`ysiw`) |
| `,x` | Formater le XML (xmllint) |
| `»` / `«` | Hunk git suivant / précédent |
| `,t` | Test le plus proche (vim-test) |
| `,F` | Formater le buffer (conform) |
| `:W` `:Q` `:Wq`… | Tolérance aux majuscules |

## Telescope

| Touche | Action |
|---|---|
| `,c` | Fichiers |
| `,g` | Live grep |
| `,b` ou `à` | Buffers |
| `,n` | Historique des notifications |
| `,s` / `,S` | Symboles du document / du workspace |
| `<C-x>` `<C-v>` `<C-t>` | Ouvrir en split / vsplit / onglet |
| `<C-q>` | Envoyer dans la quickfix |

## LSP

| Touche | Action |
|---|---|
| `gd` | Définition |
| `gy` ou `grt` | Définition de type |
| `K` | Doc au survol (`KK` pour y entrer) |
| `grn` | Renommer |
| `gra` | Code action (normal et visuel) |
| `grr` | Références |
| `gri` | Implémentation |
| `grx` | Lancer le codelens |
| `gO` | Symboles du document (loclist) |
| `<C-s>` (insert) | Aide sur la signature |
| `]d` / `[d` | Diagnostic suivant / précédent |
| `]D` / `[D` | Dernier / premier diagnostic |
| `<C-w>d` | Diagnostic en flottant |

## Complétion et Copilot

| Touche | Action |
|---|---|
| `Tab` | Suivant, sinon accepter Copilot, sinon tab |
| `S-Tab` | Précédent |
| `Entrée` | Accepter |
| `<C-Space>` | Ouvrir le menu, puis afficher ou masquer la doc |
| `<C-j>` | Accepter la suggestion Copilot |
| `<C-e>,` | Expansion Emmet |

## Natif (0.11 et plus)

| Touche | Action |
|---|---|
| `gcc` / `gc{motion}` | Commenter (aussi `gc` en visuel) |
| `]q` `[q` | Quickfix suivant / précédent |
| `]b` `[b` | Buffer suivant / précédent |
| `]l` `[l` | Loclist suivant / précédent |
| `]<Espace>` / `[<Espace>` | Ligne vide dessous / dessus |
| `gx` | Ouvrir l'URL sous le curseur |

## Édition

| Touche | Action |
|---|---|
| `ys{motion}{c}` | Surround : ajouter |
| `cs{a}{b}` / `ds{c}` | Surround : changer / supprimer |
| `S{c}` (visuel) | Entourer la sélection |
| `cia` `daa` | Arguments (targets.vim) |
| `ci,` `in(` `il(` | Séparateurs, objet suivant / précédent |
| `crs` `crc` `crm` | snake_case, camelCase, MixedCase |
| `cru` `cr-` `cr.` | UPPER_CASE, kebab-case, dot.case |
| `,k` / `,K` | Surligner le mot / tout effacer |
| `n` / `N` | Mot surligné, sinon recherche |
| `<C-d>` `<C-u>` `<C-f>` `<C-b>` | Défilement fluide |
