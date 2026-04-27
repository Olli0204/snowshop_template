{block name='layout-header-top-bar'}
    {strip}
        {nav tag='ul' class='topbar-main nav-dividers grey-top-bar'}
            {block name='layout-header-safe-shopping'}
                {navitem href="Zahlungsmoeglichkeiten-1"}
                    <span class="fas fa-lock topbar-icon"></span>
                    {if $lang eq "eng"}
                        <span class="topbar-text">Secure Payment</span>
                    {else}
                        <span class="topbar-text">Sichere Bezahlung</span>
                    {/if}
                {/navitem}
            {/block}

            {block name='layout-header-apple-pay'}
                {navitem href="Zahlungsmoeglichkeiten-1"}
                    <div class="header-payment-logo">
                        <img class="visible-img topbar-payment-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/apple-pay.png" />
                    </div>
                {/navitem}
            {/block}

            {block name='layout-header-paypal'}
                {navitem href="Zahlungsmoeglichkeiten-1"}
                    <div class="header-payment-logo">
                        <img class="visible-img topbar-payment-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/paypal_colour_bearbeitet.png" />
                    </div>
                {/navitem}
            {/block}

            {block name='layout-header-amazon-pay'}
                {navitem href="Zahlungsmoeglichkeiten-1"}
                    <div class="header-payment-logo">
                        <img class="visible-img topbar-payment-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/amazonpay-logo-colour.png" />
                    </div>
                {/navitem}
            {/block}

            {block name='layout-header-google-pay'}
                {navitem href="Zahlungsmoeglichkeiten-1"}
                    <div class="header-payment-logo">
                        <img class="visible-img topbar-payment-img" height="20px" src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/google-pay.png" />
                    </div>
                {/navitem}
            {/block}

            {block name='layout-header-shipment'}
                {navitem href="Versandkosten-Liefergebiet"}
                    <span class="fas fa-cube topbar-icon"></span>
                    {if $lang eq "eng"}
                        <span class="topbar-text">Free Delivery On Orders Over 100€</span>
                    {else}
                        <span class="topbar-text">Gratis Versand ab 100€</span>
                    {/if}
                {/navitem}
            {/block}
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
