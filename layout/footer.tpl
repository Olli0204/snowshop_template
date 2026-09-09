{*
    Snowshop – Footer (Basis: NOVA 5.8.0 layout/footer.tpl).
    Aufbau: Newsletter-Band (Akzentfarbe) → Hauptbereich (Marke/Kontakt + Linkboxen) → Vertrauensleiste (Zahlung,
    Versand, Sicherheit) → Copyright-Zeile mit Widerrufslink und Preishinweis.
    Kontaktdaten, Claim und Öffnungszeiten kommen aus den Template-Einstellungen (Bereich "Snowshop").
*}
{block name='layout-footer'}

    {block name='layout-footer-content-all-closingtags'}

        {block name='layout-footer-aside'}
            {if !$bExclusive && $boxes.left !== null && !empty(trim(strip_tags($boxes.left)))
                && (($Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive) || $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp)}
                {block name='layout-footer-content-productlist-col-closingtag'}
                    </div>{* /col *}
                    {block name='layout-footer-sidepanel-left'}
                         <aside id="sidepanel_left" class="sidepanel-left d-print-none col-12 col-lg-4 col-xl-3 order-last order-lg-first dropdown-full-width">
                             {block name='footer-sidepanel-left-content'}{$boxes.left}{/block}
                         </aside>
                    {/block}
                {/block}
                {block name='layout-footer-content-productlist-row-closingtag'}
                    </div>{* /row *}
                {/block}
            {/if}
        {/block}

        {block name='layout-footer-content-closingtag'}
            {opcMountPoint id='opc_content' title='Default Area' inContainer=false}
            </div>{* /content *}
        {/block}

        {block name='layout-footer-content-wrapper-closingtag'}
            </div>{* /content-wrapper*}
        {/block}
    {/block}

    {block name='layout-footer-main-wrapper-closingtag'}
        </main> {* /mainwrapper *}
    {/block}

    {block name='layout-footer-content'}
        {if !$bExclusive}
            {$newsletterActive = $Einstellungen.template.footer.newsletter_footer === 'Y'
                && $Einstellungen.newsletter.newsletter_active === 'Y'}
            {$spSettings = $Einstellungen.template.snowshop|default:[]}
            {$spIsEn     = $lang === 'eng'}
            {$spTagline  = ($spIsEn && !empty($spSettings.footer_tagline_en)) ? $spSettings.footer_tagline_en : $spSettings.footer_tagline|default:''}
            {$spHours    = ($spIsEn && !empty($spSettings.footer_hours_en)) ? $spSettings.footer_hours_en : $spSettings.footer_hours|default:''}
            {$spAddress  = $spSettings.footer_address|default:''}
            {$spPhone    = $spSettings.footer_phone|default:''}
            {$spMail     = $spSettings.footer_mail|default:''}
            {$spShopName = $Einstellungen.global.global_shopname|default:'Snowshop'}
            <footer id="footer" class="snowshop-footer{if $newsletterActive} newsletter-active{/if}">
                {if $newsletterActive}
                    {block name='layout-footer-newsletter'}
                        <div class="snowshop-footer__newsletter d-print-none">
                            {container}
                                {row class="newsletter-footer align-items-center"}
                                    {col cols=12 lg=6}
                                        {block name='layout-footer-newsletter-heading'}
                                            <div class="h2 newsletter-footer-heading">
                                                {lang key='newsletter' section='newsletter'} {lang key='newsletterSendSubscribe' section='newsletter'}
                                            </div>
                                        {/block}
                                        {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                                        {block name='layout-footer-newsletter-info'}
                                            <p class="info">
                                                {lang key='newsletterInformedConsent' section='newsletter' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}
                                            </p>
                                        {/block}
                                        {/if}
                                    {/col}
                                    {col cols=12 lg=6}
                                        {block name='layout-footer-form'}
                                            {form methopd="post" action="{get_static_route id='newsletter.php'}"}
                                                {block name='layout-footer-form-content'}
                                                    {input type="hidden" name="abonnieren" value="2"}
                                                    {formgroup class="newsletter-email-wrapper"
                                                        label-for="newsletter_email"
                                                        label="{lang key='newsletter' section='newsletter'} {lang key='newsletterSendSubscribe' section='newsletter'}"
                                                        label-sr-only=true}
                                                        {inputgroup}
                                                            {input type="email" name="cEmail" id="newsletter_email" placeholder="{lang key='emailadress'}" autocomplete="email" aria=['label' => {lang key='emailadress'}]}
                                                            {inputgroupaddon append=true}
                                                                {button type='submit' variant='dark' class='min-w-sm snowshop-footer__newsletter-btn'}
                                                                    {lang key='newsletterSendSubscribe' section='newsletter'}
                                                                {/button}
                                                            {/inputgroupaddon}
                                                        {/inputgroup}
                                                    {/formgroup}
                                                {/block}
                                                {block name='layout-footer-form-captcha'}
                                                    <div class="{if !empty($plausiArr.captcha) && $plausiArr.captcha === true} has-error{/if}">
                                                        {captchaMarkup getBody=true}
                                                    </div>
                                                {/block}
                                            {/form}
                                        {/block}
                                    {/col}
                                {/row}
                            {/container}
                        </div>
                    {/block}
                {/if}
                {container class="d-print-none snowshop-footer__main"}
                    {block name='layout-footer-boxes'}
                        {getBoxesByPosition position='bottom' assign='footerBoxes'}
                        {row id='footer-boxes'}
                            {block name='layout-footer-brand'}
                                {col cols=12 lg=4 class="snowshop-footer__brand"}
                                    <div class="snowshop-footer__logo">{$spShopName|escape:'html'}</div>
                                    {if $spTagline !== ''}
                                        <p class="snowshop-footer__tagline">{$spTagline|escape:'html'}</p>
                                    {/if}
                                    {if $spAddress !== '' || $spPhone !== '' || $spMail !== '' || $spHours !== ''}
                                        <ul class="list-unstyled snowshop-footer__contact">
                                            {if $spAddress !== ''}
                                                <li><i class="fas fa-map-marker-alt" aria-hidden="true"></i><span>{$spAddress|escape:'html'|nl2br}</span></li>
                                            {/if}
                                            {if $spPhone !== ''}
                                                <li><i class="fas fa-phone" aria-hidden="true"></i><a href="tel:{$spPhone|regex_replace:'/[^0-9+]/':''}">{$spPhone|escape:'html'}</a></li>
                                            {/if}
                                            {if $spMail !== ''}
                                                <li><i class="fas fa-envelope" aria-hidden="true"></i><a href="mailto:{$spMail|escape:'html'}">{$spMail|escape:'html'}</a></li>
                                            {/if}
                                            {if $spHours !== ''}
                                                <li><i class="far fa-clock" aria-hidden="true"></i><span>{$spHours|escape:'html'|nl2br}</span></li>
                                            {/if}
                                        </ul>
                                    {/if}
                                    {block name='layout-footer-socialmedia'}
                                        {if $Einstellungen.template.footer.socialmedia_footer === 'Y'}
                                            {$spSocial = [
                                                'facebook'  => ['fab fa-facebook-f', 'Facebook'],
                                                'instagram' => ['fab fa-instagram', 'Instagram'],
                                                'tiktok'    => ['fab fa-tiktok', 'TikTok'],
                                                'youtube'   => ['fab fa-youtube', 'YouTube'],
                                                'pinterest' => ['fab fa-pinterest-p', 'Pinterest'],
                                                'twitter'   => ['fab fa-twitter', 'Twitter'],
                                                'vimeo'     => ['fab fa-vimeo-v', 'Vimeo'],
                                                'linkedin'  => ['fab fa-linkedin-in', 'LinkedIn'],
                                                'xing'      => ['fab fa-xing', 'Xing'],
                                                'skype'     => ['fab fa-skype', 'Skype']
                                            ]}
                                            <ul class="list-unstyled snowshop-footer__social">
                                                {foreach $spSocial as $spNetwork => $spMeta}
                                                    {$spSocialUrl = $Einstellungen.template.footer.$spNetwork|default:''}
                                                    {if $spSocialUrl !== ''}
                                                        <li>
                                                            {link href="{if strpos($spSocialUrl, 'http') !== 0}https://{/if}{$spSocialUrl}"
                                                                class="snowshop-footer__social-link btn-{$spNetwork}"
                                                                aria=['label'=>"{lang key='visit_us_on' section='aria' printf=$spMeta[1]}"]
                                                                title=$spMeta[1] target="_blank" rel="noopener"}
                                                                <i class="{$spMeta[0]} fa-fw" aria-hidden="true"></i>
                                                            {/link}
                                                        </li>
                                                    {/if}
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    {/block}
                                {/col}
                            {/block}
                            {col cols=12 lg=8 class="snowshop-footer__boxes"}
                                {row}
                                    {if isset($footerBoxes) && count($footerBoxes) > 0}
                                        {foreach $footerBoxes as $box}
                                            {if $box->isActive() && !empty($box->getRenderedContent())}
                                                <div class="col-12 col-sm-6 col-lg snowshop-footer__box">
                                                    {$box->getRenderedContent()}
                                                </div>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                {/row}
                            {/col}
                        {/row}
                    {/block}
                {/container}
                {block name='layout-footer-trust'}
                    <div class="snowshop-footer__trust d-print-none">
                        {container}
                            <div class="snowshop-footer__trust-inner">
                                {block name='layout-footer-trust-payment'}
                                    <div class="snowshop-footer__trust-group">
                                        <span class="snowshop-footer__trust-label">{if $spIsEn}Payment{else}Bezahlung{/if}</span>
                                        <span class="snowshop-footer__chip"><img src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/paypal_white_bearbeitet.png" alt="PayPal" height="20" loading="lazy"></span>
                                        <span class="snowshop-footer__chip"><img src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/amazonpay-logo-white.png" alt="Amazon Pay" height="20" loading="lazy"></span>
                                        <span class="snowshop-footer__chip"><img src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/apple-pay.png" alt="Apple Pay" height="20" loading="lazy"></span>
                                        <span class="snowshop-footer__chip"><img src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/google-pay.png" alt="Google Pay" height="20" loading="lazy"></span>
                                        <span class="snowshop-footer__chip snowshop-footer__chip--text">{if $spIsEn}Prepayment{else}Vorkasse{/if}</span>
                                    </div>
                                {/block}
                                {block name='layout-footer-trust-shipping'}
                                    <div class="snowshop-footer__trust-group">
                                        <span class="snowshop-footer__trust-label">{if $spIsEn}Shipping{else}Versand{/if}</span>
                                        <span class="snowshop-footer__chip"><img src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/dpd_white.png" alt="DPD" height="22" loading="lazy"></span>
                                        <span class="snowshop-footer__chip"><img src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/dhl_white.png" alt="DHL" height="22" loading="lazy"></span>
                                    </div>
                                {/block}
                                {block name='layout-footer-trust-secure'}
                                    <div class="snowshop-footer__trust-group">
                                        <span class="snowshop-footer__trust-label">{if $spIsEn}Secure shopping{else}Sicher einkaufen{/if}</span>
                                        <span class="snowshop-footer__chip"><img src="{$shopURL}/{$currentTemplateDir}mediafiles/special_logos/ssl_white.png" alt="SSL" height="22" loading="lazy"></span>
                                    </div>
                                {/block}
                            </div>
                        {/container}
                    </div>
                {/block}
                {block name='layout-footer-copyright'}
                    <div id="copyright" class="snowshop-footer__bottom">
                        {container}
                            <div class="snowshop-footer__bottom-inner">
                                {block name='layout-footer-copyright-copyright'}
                                    <div class="snowshop-footer__copyright">
                                        <span itemprop="copyrightHolder">&copy; {$smarty.now|date_format:'%Y'} {if !empty($meta_copyright)}{$meta_copyright}{else}{$spShopName|escape:'html'}{/if}</span>
                                        {if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}
                                            <span class="ml-2">{lang key='counter'}: {$Besucherzaehler}</span>
                                        {/if}
                                        {if !empty($Einstellungen.global.global_fusszeilehinweis)}
                                            <span class="ml-2">{$Einstellungen.global.global_fusszeilehinweis}</span>
                                        {/if}
                                    </div>
                                {/block}
                                <div class="snowshop-footer__legal">
                                    {block name='layout-footer-withdrawal'}
                                        <div class="withdrawal-link-wrapper">
                                            {include file='snippets/withdrawal_link.tpl'}
                                        </div>
                                    {/block}
                                    <div class="footnote-vat">
                                        {if $NettoPreise == 1}
                                            {lang key='footnoteExclusiveVat' assign='footnoteVat'}
                                        {else}
                                            {lang key='footnoteInclusiveVat' assign='footnoteVat'}
                                        {/if}
                                        {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                                            {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
                                                {lang key='footnoteExclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                            {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
                                                {lang key='footnoteInclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                            {/if}
                                        {/if}
                                        {block name='footer-vat-notice'}
                                            <span class="small">* {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}</span>
                                        {/block}
                                    </div>
                                </div>
                                {if !JTL\Shop::isBrandfree()}
                                    {block name='layout-footer-copyright-brand'}
                                        <div class="snowshop-footer__credits" id="system-credits">
                                            Powered by {link href="https://jtl-url.de/jtlshop" title="JTL-Shop" target="_blank" rel="noopener"}JTL-Shop{/link}
                                        </div>
                                    {/block}
                                {/if}
                            </div>
                        {/container}
                    </div>
                {/block}
                {block name='layout-footer-scroll-top'}
                    {if $Einstellungen.template.theme.button_scroll_top === 'Y'}
                        {include file='snippets/scroll_top.tpl'}
                    {/if}
                {/block}
            </footer>
        {/if}
    {/block}

    {block name='layout-footer-io-path'}
        <div id="jtl-io-path" data-path="{$ShopURL}" class="d-none"></div>
    {/block}

    {* JavaScripts *}
    {block name='layout-footer-js'}
        {$dbgBarBody}
        {captchaMarkup getBody=false}
    {/block}
    </body>
    </html>
{/block}
