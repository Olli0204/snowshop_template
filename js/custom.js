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

/*
 * Fix: Trusted-Shops-Trustbadge erscheint nach der Cookie-Zustimmung nicht.
 *
 * Ursache im Cookie-Plugin (ws5_eucookie): Ohne Zustimmung schreibt es beim Rendern das src eines Scripts
 * nach data-src. Beim Freischalten (main-v2.6.0.js, Funktion st) überspringt es aber jedes Script, das kein
 * data-type trägt („already unblocked. Skipping.“). Das Snippet der Trusted-Shops-App hat kein type-Attribut,
 * also bleibt es für immer blockiert. Sichtbar wird das durch den LiteSpeed-Cache: Die meisten gecachten
 * Seiten stammen von Besuchern ohne Zustimmung (data-src), und auch wer zugestimmt hat, bekommt diese Fassung.
 *
 * Lösung: Blockierte Scripts ohne data-type selbst freischalten, sobald für ihren Dienst eine Zustimmung
 * vorliegt – beim Laden der Seite (Cookie eu_cookie_store) und nach einer Änderung (euCookie_consentChanged).
 */
(function () {
    'use strict';

    var SELECTOR = 'script[data-service_id][data-src]:not([src]):not([data-type])';

    function storedConsent() {
        var match = document.cookie.match(/(?:^|;\s*)eu_cookie_store=([^;]*)/);
        if (!match) {
            return {};
        }
        try {
            return JSON.parse(decodeURIComponent(match[1])) || {};
        } catch (e) {
            return {};
        }
    }

    function hasConsent(serviceId, stored) {
        var services = window.EuCookie && window.EuCookie.services;
        if (Array.isArray(services)) {
            for (var i = 0; i < services.length; i++) {
                if (services[i] && services[i].serviceId === serviceId) {
                    return services[i].consent === true;
                }
            }
        }
        return stored[serviceId] === true;
    }

    function unblock() {
        var stored = storedConsent();
        document.querySelectorAll(SELECTOR).forEach(function (blocked) {
            if (!hasConsent(blocked.getAttribute('data-service_id'), stored)) {
                return;
            }
            var script = document.createElement('script');
            Array.prototype.forEach.call(blocked.attributes, function (attr) {
                if (attr.name !== 'data-src') {
                    script.setAttribute(attr.name, attr.value);
                }
            });
            script.src = blocked.getAttribute('data-src');
            blocked.parentNode.replaceChild(script, blocked);
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', unblock);
    } else {
        unblock();
    }
    document.addEventListener('euCookie_consentChanged', unblock);
})();
