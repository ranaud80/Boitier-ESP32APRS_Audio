# Boîtiers imprimables en 3D pour ESP32APRS_Audio

Boîtiers à imprimer en 3D pour les cartes matérielles du projet
**[ESP32APRS_Audio](https://github.com/nakhonthai/ESP32APRS_Audio)** de Somkiat Nakhonthai (HS5TQA).

ESP32APRS_Audio est un firmware APRS pour ESP32 : passerelle Internet (IGate), relais numérique (DIGI),
tracker, météo et télémétrie, avec modem AFSK 1200 bauds intégré. Il fonctionne avec plusieurs cartes
d'interface conçues par l'auteur, qui relient un ESP32 à un émetteur-récepteur ou à un module radio.
Ce dépôt ne contient **que des boîtiers** : pour le firmware, les schémas, les Gerber et la nomenclature
des cartes, voir le [dépôt d'origine](https://github.com/nakhonthai/ESP32APRS_Audio).

## Boîtiers disponibles

Chaque carte a son propre répertoire.

| Carte | Description | Répertoire | État |
|---|---|---|---|
| **ESP32DR Simple** | Interface 64 × 58 mm : ESP32 DevKit, prise RJ11 vers le poste radio, écran OLED 1,3" en option | [`ESP32DR Simple/`](ESP32DR%20Simple/) | Disponible, fond imprimé et validé |
| **ESP32DR SA868** | Carte ESP32 avec module radio SA868 / SA818 intégré | — | À venir |
| **ESP32-C3 + GPS** | Version compacte à ESP32-C3 avec GPS (tracker) | — | À venir |

![Boîtier ESP32DR Simple](ESP32DR%20Simple/images/apercu_boitier.png)

## Contenu de chaque répertoire

- un fichier source **OpenSCAD** (`.scad`) paramétrique, à ouvrir avec [OpenSCAD](https://openscad.org/) (gratuit) pour adapter les cotes ;
- des fichiers **STL** prêts à imprimer, déjà orientés pour une impression sans supports ;
- des images d'aperçu et un `README` qui explique quelle pièce imprimer et comment monter le boîtier.

Pour modifier un boîtier : ouvrir le `.scad`, changer les paramètres en tête de fichier,
puis aperçu (F5), rendu (F6) et export STL (F7).

## Contenu généré par IA

Par transparence : les boîtiers de ce dépôt ont été **conçus et générés par une IA**
(Claude, d'Anthropic) à la demande de ranaud80, qui en a fixé le cahier des charges,
imprimé et testé les pièces, et demandé les corrections.

| Élément | Origine |
|---|---|
| Sources OpenSCAD (`.scad`), fichiers STL, images d'aperçu | Générés par IA |
| Textes des README | Rédigés par IA |
| Relevé des cotes sur les Gerber du projet d'origine | Effectué par IA |
| Cahier des charges, choix des versions, impression et validation sur la carte réelle | ranaud80 |

Chaque README de carte indique ce qui a été vérifié sur une impression réelle et ce qui ne l'a pas encore été.

## Licence

Les boîtiers (sources OpenSCAD, STL, images, textes) sont publiés sous licence
**[Creative Commons Attribution - Partage dans les mêmes conditions 4.0 International (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/deed.fr)** :
vous pouvez les imprimer, les modifier et les redistribuer, y compris pour un usage commercial,
à condition de citer ce dépôt et de partager vos modifications sous la même licence.
Texte complet : [`LICENSE`](LICENSE).

**Exception :** les images de contrôle `controle_ouvertures.png` contiennent un tracé de la sérigraphie
et des perçages des cartes, tiré des fichiers Gerber du projet d'origine. Elles relèvent donc de la
licence **GPL-3.0** de ce projet.

## Crédits

- Cartes électroniques et firmware : [nakhonthai/ESP32APRS_Audio](https://github.com/nakhonthai/ESP32APRS_Audio), © Somkiat Nakhonthai (HS5TQA), licence GPL-3.0.
- Boîtiers : conçus spécialement pour ce dépôt, sans réutiliser de fichier du projet d'origine. Les cotes
  des cartes (contour, trous de fixation, position des connecteurs) ont été relevées sur les fichiers
  Gerber publiés dans le dépôt d'origine.
