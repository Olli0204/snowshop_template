{block name='layout-header-top-bar'}
    {strip} 



        {nav tag='ul' class='topbar-main nav-dividers {* Einfügen der Styles *} grey-top-bar'}
        {* Hier wurden die Snippets für die Währung und die Sprache in der obersten Zeile deaktiviert. *}
            {* {block name='layout-header-top-bar-user-settings'}
                {block name='layout-header-top-bar-user-settings-currency'}
                    {include file='snippets/currency_dropdown.tpl'}
                {/block}
                {block name='layout-header-top-bar-user-settings-include-language-dropdown'}
                    {include file='snippets/language_dropdown.tpl'}
                {/block}
            {/block} *}

            {block name='layout-header-safe-shopping'}
            {navitem href="Zahlungsmoeglichkeiten-1"}
                <span class="fas fa-lock" style="margin-left: 15px;"><span style="color: transparent;">_</span></span>
                {if $lang eq "eng"}
                <span style="margin-right: 15px;">Secure Payment</span>
                {else}
                <span style="margin-right: 15px;">Sichere Bezahlung</span>
                {/if}
            {/navitem}
        {/block}
    {* Einbindung des Apple Pay Logos *}
    {block name='layout-header-paypal'}
        {navitem href="Zahlungsmoeglichkeiten-1"}
        <div class="header-payment-logo">
            <img class="visible-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/apple-pay.png" style="margin-top: 2px !important;" />
        </div>
        {/navitem}
    {/block}

    {* Einbindung des Paypal Logos *}
    {block name='layout-header-paypal'}
        {navitem href="Zahlungsmoeglichkeiten-1"}
        <div class="header-payment-logo">
            <img class="visible-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/paypal_colour_bearbeitet.png" style="margin-top: 2px !important;" />
        </div>
        {/navitem}
    {/block} 

    {* Einbindung des Amazon-Pay Logos *}
    {block name='layout-header-amazon-pay'}
            {navitem href="Zahlungsmoeglichkeiten-1"}
                <div class="header-payment-logo">
                    <img class="visible-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/amazonpay-logo-colour.png" style="margin-top: 2px !important;" />
                </div>
            {/navitem}
    {/block} 

    {* Einbindung des Google Pay Logos *}
    {block name='layout-header-paypal'}
        {navitem href="Zahlungsmoeglichkeiten-1"}
        <div class="header-payment-logo">
            <img class="visible-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/google-pay.png" style="margin-top: 2px !important;" />
        </div>
        {/navitem}
    {/block}
    
    {block name='layout-header-shipment'}
        {navitem href="Versandkosten-Liefergebiet"}
            <span class="fas fa-cube" style="margin-left: 15px;"><span style="color: transparent;">_</span></span>
            {if $lang eq "eng"}
            <span style="margin-right: 15px;">Free Delivery On Orders Over 100€</span>
            {else}
            <span style="margin-right: 15px;">Gratis Versand ab 100€</span>
            {/if}
        {/navitem}
    {/block} 


        {* {if $linkgroups->getLinkGroupByTemplate('Kopf') !== null && $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}
            {block name='layout-header-top-bar-cms-pages'}
                {foreach $linkgroups->getLinkGroupByTemplate('Kopf')->getLinks() as $Link}
                    {navitem active=$Link->getIsActive() href=$Link->getURL() title=$Link->getTitle() target=$Link->getTarget()}
                        {$Link->getName()}
                    {/navitem}
                {/foreach}
            {/block}
        {/if} *}
        {/nav}
        {if $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}
            {block name='layout-header-top-bar-note'}
                {$topbarLang = {lang key='topbarNote'}}
                {if $topbarLang !== ''}
                    {nav tag='ul' class='topbar-note nav-dividers'}
                        {navitem id="topbarNote"}{$topbarLang}{/navitem}
                    {/nav}
                {/if}
            {/block}
        {/if}
    {/strip}
{/block}
