/*
 * Snowshop – eigenes JavaScript (wird nach den NOVA-Skripten geladen).
 */

/*
 * Fix: Aufklappbare Boxen (z. B. Footer-Linkboxen, Filter in der Seitenleiste auf dem Smartphone)
 * springen beim Antippen zum Seitenanfang.
 *
 * Ursache in NOVA (global.js, setCustomAnchorScrolling): Jeder Link mit href="#…" bekommt einen
 * Smooth-Scroll-Handler, der zum Zielelement scrollt. Ausgenommen sind nur Tabs und Pills, nicht aber
 * Bootstrap-Collapse-Trigger (data-toggle="collapse"). Deren Ziel ist beim Klick noch eingeklappt
 * (display: none), Position 0 – also scrollt NOVA nach oben.
 *
 * Lösung: Der NOVA-Handler wird von allen Collapse-Ankern entfernt. Bootstrap übernimmt das
 * Auf-/Zuklappen wie gewohnt. Falls der NOVA-Handler in einer künftigen Version nicht mehr global
 * erreichbar ist, greift ein Fallback, der das Collapse selbst auslöst.
 */
(function () {
    'use strict';

    var SELECTOR = 'a[data-toggle="collapse"][href^="#"]';

    function detachNovaScrollHandler() {
        /* global customAnchorScrollingListener */
        // NOVA deklariert den Handler als globale const (kein window-Property), daher der direkte Bezeichner.
        if (typeof customAnchorScrollingListener !== 'function') {
            return false;
        }
        document.querySelectorAll(SELECTOR).forEach(function (el) {
            el.removeEventListener('click', customAnchorScrollingListener);
        });
        return true;
    }

    function fallbackCaptureHandler(event) {
        var link = event.target.closest(SELECTOR);
        if (!link || !window.jQuery || !window.jQuery.fn.collapse) {
            return;
        }
        var target = document.getElementById(link.getAttribute('href').slice(1));
        if (!target) {
            return;
        }
        event.preventDefault();
        event.stopImmediatePropagation();
        window.jQuery(target).collapse('toggle');
    }

    function apply() {
        window.snowshopCollapseFixMode = detachNovaScrollHandler() ? 'detach' : 'fallback';
        if (window.snowshopCollapseFixMode === 'fallback') {
            document.removeEventListener('click', fallbackCaptureHandler, true);
            document.addEventListener('click', fallbackCaptureHandler, true);
        }
    }

    // Nach dem DOM-Ready-Handler von NOVA ausführen (Registrierungsreihenfolge) …
    if (window.jQuery) {
        window.jQuery(apply);
    } else {
        document.addEventListener('DOMContentLoaded', apply);
    }

    // … und erneut, wenn NOVA Inhalte per AJAX nachlädt (z. B. Filter/Pagination) und die Handler neu setzt.
    var timer = null;
    new MutationObserver(function () {
        clearTimeout(timer);
        timer = setTimeout(apply, 100);
    }).observe(document.documentElement, { childList: true, subtree: true });
})();
