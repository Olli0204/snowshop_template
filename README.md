# Snowshop Template

JTL-Shop 5 Child-Template für Snowshop, basierend auf dem NOVA-Theme.

## Voraussetzungen

- JTL-Shop >= 5.7.0 (siehe `MinShopVersion` in `template.xml`)
- NOVA-Template als Parent

## Installation

Den geklonten Ordner `snowshop_template` direkt in das Verzeichnis `/templates/` des JTL-Shops kopieren.

Der Ordnername **muss** mit dem Namespace in `Bootstrap.php` übereinstimmen (`Template\snowshop_template`). Da das Repository genauso heißt, passt der von `git clone` erzeugte Ordnername bereits — er muss **nicht** umbenannt werden:

```bash
git clone git@github.com:Olli0204/snowshop_template.git /pfad/zum/shop/templates/snowshop_template
```

Der Name ist bewusst **versionsunabhängig**: Bei Shop-Updates bleibt er gleich, die Version wird nur in `template.xml` gepflegt. So entfällt das frühere Umbenennen von Ordner + Namespace bei jedem Update.

## Themes

Das Template enthält zwei wählbare Themes, konfigurierbar im Template-Einstellungen:

| Theme | Beschreibung |
|---|---|
| `my-nova` | Eigenes Theme ohne feste Farbdefinitionen (NOVA "clear" als Basis) |
| `snowshop` | Snowshop-Theme mit Brand-Farben (`#FFA54F` primary, `#525252` secondary) |

## Struktur

- **`layout/`** — Überschreibt NOVA-Layouts: Header, Footer, Top-Bar, Navigations-Icons, Sprachumschalter
- **`snippets/categories_mega.tpl`** — Mega-Menü mit SALE-Kategorie-Hervorhebung
- **`productdetails/price.tpl`** — Preisdarstellung inkl. Staffelpreise und Sonderpreise
- **`themes/my-nova/`** — SCSS + kompiliertes CSS für das my-nova Theme; `custom.css` für Anpassungen ohne SCSS-Compiler
- **`themes/snowshop/`** — SCSS + kompiliertes CSS für das Snowshop-Theme; `custom.css` für Anpassungen
- **`js/custom.js`** — Eigenes JavaScript (wird als letztes geladen)
- **`mediafiles/`** — Template-eigene Bilder (Frontpage-Banner, Payment-/Versand-Logos)

## CSS anpassen

Kleine CSS-Anpassungen direkt in `themes/<theme>/custom.css` eintragen — diese Datei wird nach dem kompilierten CSS geladen und überschreibt es.

Für größere Änderungen die SCSS-Dateien unter `themes/<theme>/sass/` bearbeiten und anschließend mit dem JTL-Theme-Editor Plugin oder einem externen SCSS-Compiler neu kompilieren.

## Top-Bar

Die Top-Bar (`layout/header_top_bar.tpl`) zeigt Payment-Logos und Versandhinweise. Jedes Logo hat einen eigenen Smarty-Block für einfache Überschreibbarkeit:

- `layout-header-safe-shopping` — "Sichere Bezahlung"-Hinweis
- `layout-header-apple-pay` — Apple Pay Logo
- `layout-header-paypal` — PayPal Logo
- `layout-header-amazon-pay` — Amazon Pay Logo
- `layout-header-google-pay` — Google Pay Logo
- `layout-header-shipment` — Gratis-Versand-Hinweis
