{*
    Snowshop – Top-Bar oberhalb des Headers (Desktop).
    Vorteile (Icon + Text) nur bei Einstellung „Vorteile in der Top-Bar anzeigen“ = Ja; sonst steht der
    Newsletter-/Aktionshinweis zentriert allein in der Leiste.
    Alle Texte, Links und Icons sind Template-Einstellungen (Bereich "Snowshop"); Zahlungslogos stehen im Footer.
*}
{block name='layout-header-top-bar'}
    {strip}
        {$spSettings = $Einstellungen.template.snowshop|default:[]}
        {$spIsEn     = $lang === 'eng'}
        {$spShowUsps = ($spSettings.topbar_usps|default:'N') === 'Y'}
        {$spShowCurr = JTL\Session\Frontend::getCurrencies()|count > 1}
        {if $spShowUsps || $spShowCurr}
        {nav tag='ul' class='topbar-main snowshop-topbar__usps'}
            {block name='layout-header-top-bar-usps'}
                {for $spIdx = 1 to 3}
                    {if !$spShowUsps}{continue}{/if}
                    {$spKey  = "usp_`$spIdx`_text"}
                    {$spKeyE = "usp_`$spIdx`_text_en"}
                    {$spKeyU = "usp_`$spIdx`_url"}
                    {$spKeyI = "usp_`$spIdx`_icon"}
                    {$spText = ($spIsEn && !empty($spSettings.$spKeyE)) ? $spSettings.$spKeyE : $spSettings.$spKey|default:''}
                    {if $spText !== ''}
                        {$spUrl  = $spSettings.$spKeyU|default:''}
                        {$spIcon = $spSettings.$spKeyI|default:'fas fa-check'}
                        {navitem href=$spUrl|default:'#' class="snowshop-topbar__item"}
                            <i class="{$spIcon|regex_replace:'/[^a-z0-9 _-]/i':''}" aria-hidden="true"></i>
                            <span>{$spText|escape:'html'}</span>
                        {/navitem}
                    {/if}
                {/for}
            {/block}
            {block name='layout-header-top-bar-user-settings'}
                {block name='layout-header-top-bar-user-settings-currency'}
                    {if $spShowCurr}
                        {include file='snippets/currency_dropdown.tpl'}
                    {/if}
                {/block}
            {/block}
        {/nav}
        {/if}
        {if $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}
            {block name='layout-header-top-bar-note'}
                {$spPromoText = ($spIsEn && !empty($spSettings.promo_text_en)) ? $spSettings.promo_text_en : $spSettings.promo_text|default:''}
                {$spPromoUrl  = $spSettings.promo_url|default:''}
                {if $spPromoText !== ''}
                    {nav tag='ul' class='topbar-note snowshop-topbar__promo'}
                        {navitem id="topbarNote" href=$spPromoUrl|default:'#' class="snowshop-topbar__promo-link"}
                            <i class="fas fa-gift" aria-hidden="true"></i>
                            <span>{$spPromoText|escape:'html'}</span>
                            <i class="fas fa-chevron-right snowshop-topbar__arrow" aria-hidden="true"></i>
                        {/navitem}
                    {/nav}
                {/if}
            {/block}
        {/if}
    {/strip}
{/block}
