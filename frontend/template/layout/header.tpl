{if $smarty.server.REQUEST_URI|strstr: 'vermietung' or $smarty.server.REQUEST_URI|strstr: 'rental' or $smarty.server.REQUEST_URI|strstr: 'produkt-details' or $smarty.server.REQUEST_URI|strstr: 'product-details' or $smarty.server.REQUEST_URI|strstr: 'meine-vermietungen' or $smarty.server.REQUEST_URI|strstr: 'my-rentals'}
    {block name='layout-header-content-wrapper-starttag'}
    <div style="padding-top: 0;" id="content-wrapper" class="{if ($Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive) || $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp}has-left-sidebar container-fluid container-fluid-xl{/if}
            {if $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp}is-item-list{/if}
                {if $isFluidBanner || $isFluidSlider} has-fluid{/if}">
    {/block}

    {block name='layout-header-content-starttag'}
        <div id="content" style="padding-bottom: 0;">
    {/block}

    {block name='layout-header-breadcrumb'}
    {/block}
{/if}

{*categories*}
{block name='layout-header-include-categories-mega'}
    <div id="mainNavigation" class="collapse navbar-collapse nav-scrollbar">
        {block name='layout-header-include-include-categories-header'}
            <div class="nav-mobile-header d-lg-none">
                {row class="align-items-center-util"}
                    {col class="nav-mobile-header-toggler"}
                        {block name='layout-header-include-categories-mega-toggler'}
                            <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                        {/block}
                    {/col}
                    {col class="col-auto nav-mobile-header-name ml-auto-util"}
                        <span class="nav-offcanvas-title">{lang key='menuName'}</span>
                        {block name='layout-header-include-categories-mega-back'}
                            {link href="#" class="nav-offcanvas-title d-none" data=["menu-back"=>""]}
                                <span class="fas fa-chevron-left icon-mr-2"></span>
                                <span>{lang key='back'}</span>
                            {/link}
                        {/block}
                    {/col}
                {/row}
                <hr class="nav-mobile-header-hr" />
            </div>
        {/block}

        {block name='rental-link'}
            <div style="padding-left: 1rem; padding-right: 1rem;" class="plugin-link-sm">
                <div>
                    {if $smarty.session.kSprache eq 2}
                        <a class='pl-0 nav-link' href='{$ShopURL}/rental'>rental</a>
                    {else}
                        <a class='pl-0 nav-link' href='{$ShopURL}/vermietung'>vermietung</a>
                    {/if}
                </div>
                <hr class="mt-0 mb-0 nav-mobile-header-hr" />
            </div>
        {/block}

        {block name='layout-header-include-include-categories-body'}
            <div class="nav-mobile-body">
                {navbarnav class="nav-scrollbar-inner mr-auto"}
                    {block name='layout-header-include-include-categories-mega'}
                        {include file='snippets/categories_mega.tpl'}
                    {/block}
                {/navbarnav}
            </div>
        {/block}
    </div>
{/block}