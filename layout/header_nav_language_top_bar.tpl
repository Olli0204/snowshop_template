{* Integration für Sprachendropdown mit Globus als Logo *}
{block name='layout-header-shop-nav-language'}
    {navitemdropdown
        no-caret=true
        right=true
        text='<span class="fas fa-globe-europe"></span>'
        class="language-icon-dropdown"}
            {foreach $smarty.session.Sprachen as $language}
                {block name='snippets-language-dropdown-item'}
                    {dropdownitem href="{$language->cURL}"
                        class="link-lang"
                        data=["Test"=>$language->cISO]
                        rel="nofollow"
                        active=($language->kSprache == $smarty.session.kSprache)}
                        {$language->iso639|upper}
                    {/dropdownitem}
                {/block}
            {/foreach}
    {/navitemdropdown}
{/block}
