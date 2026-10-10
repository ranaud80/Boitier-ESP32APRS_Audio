// =====================================================================
//  Boîtier pour carte ESP32DR Simple (HS5TQA / nakhonthai)
//  Carte : 64 x 58 mm, 4 trous Ø3,2 à 3 mm des bords
//  Cotes relevées sur les Gerber officiels (Gerber_ESP32DR_Simple.zip).
//  Repère : origine = coin de la carte côté USB / côté ESP32,
//           X vers le RJ11, Y vers l'antenne WiFi, Z vers le haut.
//
//  Pièces : fond (bac) + couvercle. Impression sans supports.
//  Visserie : 3 vis M3 x 12 (tête cylindrique ou bombée) par le dessous.
//
//  Dépôt   : https://github.com/ranaud80/Boitier-ESP32APRS_Audio
//  Licence : CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
//  Ce fichier a été généré par IA (Claude, Anthropic) à la demande de
//  ranaud80, puis testé par impression réelle (fond validé).
// =====================================================================

/* [Pièce à générer] */
// "fond", "couvercle", "assemblage" (aperçu), "decoupes" (contrôle 2D)
piece = "assemblage";
// Couvercle avec fenêtre pour écran OLED 1,3" (sinon : trous de réglage SPK/MIC)
oled = false;

/* [Montage de l'ESP32 DevKit] */
// true = DevKit enfiché sur barrettes femelles ; false = soudé directement
esp_sur_supports = true;
// Hauteur du centre de la prise USB au-dessus du circuit imprimé
usb_z = esp_sur_supports ? 14.0 : 5.5;
// Hauteur libre au-dessus du circuit imprimé (composant le plus haut + marge)
h_int = esp_sur_supports ? 19 : 15;

/* [Boîtier] */
paroi   = 2.0;    // épaisseur des parois
fond_ep = 2.0;    // épaisseur du fond
couv_ep = 2.0;    // épaisseur du couvercle
entret  = 4.0;    // hauteur des entretoises sous la carte (pattes soudées)
pcb_ep  = 1.6;    // épaisseur du circuit imprimé
rayon   = 3.0;    // rayon des angles extérieurs
jeu     = 0.5;    // jeu autour de la carte (gauche et arrière)
jeu_av  = 1.0;    // jeu à l'avant (le DevKit dépasse de 0,7 mm)
jeu_dr  = 3.0;    // jeu à droite (l'écran OLED 1,3" dépasse de la carte)
jeu_emb = 0.2;    // jeu d'emboîtement du couvercle

/* [Ouvertures] */
usb_l  = 13.5;    // largeur ouverture USB (micro-USB ou USB-C)
usb_h  = 9.0;     // hauteur ouverture USB
rj_l   = 15.0;    // largeur ouverture RJ11
rj_h   = 14.5;    // hauteur ouverture RJ11 au-dessus de la carte
led_d  = 3.4;     // trous des LED (LED 3 mm)
boutons = false; // trous d'accès aux boutons EN / BOOT de l'ESP32
btn_d  = 3.5;     // diamètre de ces trous
pot_d  = 4.5;     // trous de réglage des ajustables
aeration = true;  // fentes d'aération au-dessus de l'ESP32
gravure  = true;  // textes gravés sur le couvercle
// Fenêtre OLED : centre et taille (zone active 29,4 x 14,7 d'un SH1106 1,3")
oled_c = [48.26, 31.0];
oled_t = [30.0, 17.0];

/* [Visserie] */
vis_passage = 3.4;   // trou de passage M3
vis_avant   = 2.6;   // avant-trou M3 dans le plastique
tete_d      = 6.0;   // lamage tête de vis
tete_h      = 3.0;

/* [Caché] */
$fn = 48;
eps = 0.01;
PCB = [64, 58];
// trous de fixation de la carte
T_VIS  = [[61, 3], [3, 55], [61, 55]];   // vissés
T_PION = [3, 3];                         // pion de centrage (sous le DevKit)
USB_X = 15;      // centre de la prise USB
RJ_X  = 45;      // centre du RJ11
LEDS  = [[31, 48, "PWR"], [31, 38, "TX"], [31, 28, "RX"]];
BTNS  = [[7.3, 1.9, "EN"], [22.7, 1.9, "BOOT"]];
POTS  = [[60, 36.83, "SPK"], [60, 25.0, "MIC"]];

// cavité intérieure (coordonnées carte)
x0 = -jeu;         x1 = PCB[0] + jeu_dr;
y0 = -jeu_av;      y1 = PCB[1] + jeu;
z_pcb = fond_ep + entret;          // dessous de la carte
z_top = z_pcb + pcb_ep;            // dessus de la carte
z_bac = z_top + h_int;             // haut du bac
levre_ep = 1.4; levre_h = 3.0;

module rrect(xa, ya, xb, yb, r) {
  hull() for (x = [xa + r, xb - r], y = [ya + r, yb - r]) translate([x, y]) circle(r);
}
module ext2d() { rrect(x0 - paroi, y0 - paroi, x1 + paroi, y1 + paroi, rayon); }
module int2d(d = 0) { rrect(x0 + d, y0 + d, x1 - d, y1 - d, max(rayon - paroi - d, 0.3)); }

// ---------------------------------------------------------------- fond
module fond() {
  difference() {
    union() {
      difference() {
        linear_extrude(z_bac) ext2d();
        translate([0, 0, fond_ep]) linear_extrude(z_bac) int2d();
      }
      // entretoises vissées
      for (p = T_VIS) translate([p[0], p[1], 0]) cylinder(d = 7.6, h = z_pcb);
      // entretoise + pion de centrage
      translate([T_PION[0], T_PION[1], 0]) {
        cylinder(d = 7.6, h = z_pcb);
        cylinder(d = 2.8, h = z_pcb + 1.4);
      }
    }
    // passages de vis + lamages par le dessous
    for (p = T_VIS) translate([p[0], p[1], -eps]) {
      cylinder(d = vis_passage, h = z_pcb + 1);
      cylinder(d = tete_d, h = tete_h);
    }
    // ouverture USB (encoche ouverte vers le haut)
    translate([USB_X - usb_l / 2, y0 - paroi - 1, z_top + usb_z - usb_h / 2])
      cube([usb_l, paroi + 2, z_bac]);
    // ouverture RJ11 (fenêtre fermée, pont imprimable)
    translate([RJ_X - rj_l / 2, y0 - paroi - 1, z_top - 0.5])
      cube([rj_l, paroi + 2, rj_h + 0.5]);
  }
}

// ----------------------------------------------------------- couvercle
module texte(t, taille = 3.2, ha = "center") {
  translate([0, 0, z_bac + couv_ep - 0.5])
    linear_extrude(1) text(t, size = taille, halign = ha, valign = "center",
                           font = "Liberation Sans:style=Bold");
}
module decoupes_couvercle() {       // en 2D, coordonnées carte
  for (l = LEDS) translate([l[0], l[1]]) circle(d = led_d);
  if (boutons) for (b = BTNS) translate([b[0], b[1]]) circle(d = btn_d);
  if (oled) translate(oled_c) square(oled_t, center = true);
  else for (p = POTS) translate([p[0], p[1]]) circle(d = pot_d);
  if (aeration) for (y = [11 : 4 : 39])
    hull() for (x = [7.5, 18.5]) translate([x, y]) circle(d = 1.8);
}
module couvercle() {
  difference() {
    union() {
      translate([0, 0, z_bac]) linear_extrude(couv_ep) ext2d();
      // lèvre d'emboîtement
      translate([0, 0, z_bac - levre_h]) linear_extrude(levre_h + eps) difference() {
        int2d(jeu_emb);
        int2d(jeu_emb + levre_ep);
      }
      // colonnes : serrent la carte sur les entretoises et reçoivent les vis
      for (p = T_VIS) translate([p[0], p[1], z_top]) cylinder(d = 6.2, h = h_int + eps);
    }
    for (p = T_VIS) translate([p[0], p[1], z_top - eps]) cylinder(d = vis_avant, h = 10);
    translate([0, 0, z_bac - levre_h - 1]) linear_extrude(levre_h + couv_ep + 2) decoupes_couvercle();
    // la lèvre ne doit pas gêner la fiche USB
    translate([USB_X - usb_l / 2 - 0.5, y0 - 1, z_bac - levre_h - 1]) cube([usb_l + 1, 4, levre_h + 1]);
    if (gravure) {
      for (l = LEDS) translate([l[0] - 3.2, l[1]]) texte(l[2], 3.0, "right");
      if (boutons) for (b = BTNS) translate([b[0], b[1] + 4.6]) texte(b[2], 2.6);
      if (!oled) for (p = POTS) translate([p[0] - 4, p[1]]) texte(p[2], 3.0, "right");
      translate([48, 53.5]) texte("ESP32DR", 4.0);
    }
  }
}

// ------------------------------------------- maquette de la carte (aperçu)
module carte() {
  color("green") translate([0, 0, z_pcb]) difference() {
    cube([PCB[0], PCB[1], pcb_ep]);
    for (p = concat(T_VIS, [T_PION])) translate([p[0], p[1], -1]) cylinder(d = 3.2, h = 4);
  }
  zd = z_top + (esp_sur_supports ? 11 : 2.5);
  color("dimgray") translate([1, -0.7, zd]) cube([28, 51.7, 1.6]);
  color("silver") translate([6, 26, zd + 1.6]) cube([18, 18, 3.2]);
  color("silver") translate([USB_X - 3.75, -1.7, z_top + usb_z - 1.4]) cube([7.5, 6, 2.8]);
  color("ivory") translate([RJ_X - 6.6, 0, z_top]) cube([13.2, 13, 13.3]);
  for (l = LEDS) color("red") translate([l[0], l[1], z_top]) cylinder(d = 3, h = 5.5);
  for (p = POTS) color("blue") translate([p[0] - 3.3, p[1] - 3.5, z_top]) cube([6.6, 7, 7]);
  color("black") translate([50.4, 14.6, z_top]) cylinder(d = 8, h = 12); // C6 env.
  if (oled) color("navy") translate([48.26 - 17.7, 46.1 - 33.5, z_top + 11]) cube([35.4, 33.5, 3.2]);
}

// ---------------------------------------------------------------- sortie
if (piece == "fond") fond();
else if (piece == "couvercle")        // retourné (rotation, pas miroir), prêt à imprimer
  translate([0, PCB[1], z_bac + couv_ep]) rotate([180, 0, 0]) couvercle();
else if (piece == "decoupes") decoupes_couvercle();
else {
  fond();
  carte();
  %couvercle();
}
