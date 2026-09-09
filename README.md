# Snowshop Template

JTL-Shop-5 Child-Template für Snowshop auf Basis von NOVA. Stand: **NOVA 5.8.0** (JTL-Shop 5.8.0).

## Voraussetzungen

- JTL-Shop >= 5.8.0 (siehe `MinShopVersion` in `template.xml`)
- NOVA-Template als Parent

## Installation

Den geklonten Ordner direkt in das Verzeichnis `/templates/` des JTL-Shops kopieren:

```bash
git clone git@github.com:Olli0204/snowshop_template.git /pfad/zum/shop/templates/snowshop_template
```

Der Ordnername ist frei wählbar (z. B. `snowshop_template` oder `Snowshop570`). Das Template hat bewusst **keine
eigene `Bootstrap.php`**: JTL lädt dann automatisch die Bootstrap des Parent-Templates NOVA. Eine Child-`Bootstrap.php`
müsste einen Namespace tragen, der exakt dem Ordnernamen entspricht – sonst meldet das Backend
„Fehlerhaft: Kein gültiger Namespace“.

Nach dem Kopieren: Backend → Template → Snowshop aktivieren, dann **Systemverwaltung → Cache leeren**.

## Themes

| Theme | Beschreibung |
|---|---|
| `snowshop` | Snowshop-Theme mit Brand-Farben (`#FFA54F` primary, `#525252` secondary) – Standard |
| `my-nova` | Eigenes Theme ohne feste Farbdefinitionen (NOVA "clear" als Basis) |

## Design (Header, Footer, Startseite)

Das moderne Design von Top-Bar, Header, Mega-Menü und Footer liegt in **`css/snowshop-modern.css`**.
Die Datei wird über `template.xml` (Minify) nach dem kompilierten Theme-CSS geladen und braucht **keine
SCSS-Kompilierung**. Farben kommen aus dem Theme (`--primary`).

Texte und Kontaktdaten werden im Backend gepflegt: **Template → Einstellungen → „Snowshop: Top-Bar“**

- Drei Vorteile für die Top-Bar (Text, englischer Text, Link, Font-Awesome-Icon)
- Aktionshinweis (z. B. Newsletter-Rabatt): Desktop rechts in der Top-Bar, mobil als schmale Leiste unter dem Header
- Footer: Claim, Adresse, Telefon, E-Mail, Öffnungszeiten (leer = ausgeblendet)

Die Startseite selbst wird über den OnPage Composer mit den Portlets des Plugins **Startseite Plus**
(Hero-Slider, Vorteile-Leiste, Kategorie-Kacheln, Aktions-Banner, Text und Bild) gestaltet.

## Struktur

- **`layout/header.tpl`** — NOVA 5.8.0 plus Klasse `snowshop-topbar` und Include der Hinweisleiste
- **`layout/header_top_bar.tpl`** — Top-Bar mit Vorteilen, Währungsauswahl und Aktionshinweis
- **`layout/header_promobar.tpl`** — Hinweisleiste unter dem Header (nur bis Breakpoint lg)
- **`layout/header_nav_icons.tpl`**, **`layout/header_nav_language_top_bar.tpl`** — Sprachumschalter als Globus-Icon
- **`layout/footer.tpl`** — Newsletter-Band, Marke/Kontakt, Linkboxen, Vertrauensleiste, Copyright
- **`snippets/categories_mega.tpl`** — Mega-Menü mit SALE-Hervorhebung, ohne Dropdown-Pfeile (NOVA 5.8.0-Basis)
- **`productdetails/price.tpl`** — NOVA 5.8.0 plus Klasse `sonderpreis-neue-farbe` für Sonderpreise
- **`css/snowshop-modern.css`** — Design Header/Footer
- **`themes/<theme>/sass/`** — SCSS-Quellen (nur noch Regeln, die Theme-Farben brauchen); `custom.css` für Kleinigkeiten
- **`js/custom.js`** — eigenes JavaScript
- **`mediafiles/`** — Zahlungs-/Versand-Logos, Startseiten-Bilder

## Update auf eine neue NOVA-Version

Für jede hier überschriebene Datei den NOVA-Diff prüfen (JTL veröffentlicht z. B.
`nova-v5.7.3-to-v5.8.0-tpl.diff`) und die Änderungen übernehmen. Die Child-Anpassungen sind in den Dateien
als Kommentar markiert bzw. oben beschrieben.

## Changelog

### 5.8.0
- `Bootstrap.php` entfernt: JTL nutzt die NOVA-Bootstrap des Parents; der Ordnername muss nicht mehr zum Namespace passen
- NOVA 5.8.0 übernommen: `header.tpl` (Font-Preload, neuer Slider-Include), `price.tpl` (Klassen `old-price-dynamic`,
  `discount-dynamic` für die dynamische Preisaktualisierung), `categories_mega.tpl` (`<span>` statt `<strong>` in Mobil-Überschriften)
- Neues Design für Top-Bar, Header, Mega-Menü und Footer (`css/snowshop-modern.css`)
- Top-Bar: Vorteile statt Zahlungslogos, Aktionshinweis rechts; Zahlungslogos jetzt in der Vertrauensleiste im Footer
- Footer: Newsletter-Band in Akzentfarbe, Marke mit Claim/Kontakt/Social, Linkboxen, Vertrauensleiste, Copyright-Zeile
- Template-Einstellungen „Snowshop: Top-Bar“ für alle Texte, Links und Kontaktdaten (deutsch/englisch)
- Mobil: Top-Bar nicht mehr per `display:block !important` erzwungen (Lücke unter dem Header behoben)
- SCSS aufgeräumt: alte Regeln für Slider/Bilder-Box (jetzt Plugin Startseite Plus), Top-Bar, Footer und die
  ausgeblendete Scrollbar entfernt → Theme einmal neu kompilieren (Theme-Editor)
- `template.xml`: Name „Snowshop“, Version 5.8.0, Standard-Theme `snowshop`

### 5.7.1
- NOVA 5.7.1: Withdrawal-Block übernommen
