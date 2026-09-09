{*
    Snowshop – schmale Hinweisleiste unterhalb des Headers (z. B. "Newsletter: 10 € Rabatt sichern").
    Wird nur bis zum Breakpoint lg angezeigt; ab Desktop steht der Hinweis rechts in der Top-Bar
    (layout/header_top_bar.tpl). Text und Link kommen aus den Template-Einstellungen (Bereich "Snowshop").
*}
{block name='layout-header-snowshop-promobar-content'}
    {if $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}
        {$spPromoText = ($lang === 'eng' && !empty($Einstellungen.template.snowshop.promo_text_en))
            ? $Einstellungen.template.snowshop.promo_text_en
            : $Einstellungen.template.snowshop.promo_text|default:''}
        {$spPromoUrl  = $Einstellungen.template.snowshop.promo_url|default:''}
        {if $spPromoText !== ''}
            <div class="snowshop-promobar d-lg-none">
                {if $spPromoUrl !== ''}<a class="snowshop-promobar__link" href="{$spPromoUrl|escape:'html'}">{else}<span class="snowshop-promobar__link">{/if}
                    <i class="fas fa-gift" aria-hidden="true"></i>
                    <span>{$spPromoText|escape:'html'}</span>
                    {if $spPromoUrl !== ''}<i class="fas fa-chevron-right snowshop-promobar__arrow" aria-hidden="true"></i>{/if}
                {if $spPromoUrl !== ''}</a>{else}</span>{/if}
            </div>
        {/if}
    {/if}
{/block}
