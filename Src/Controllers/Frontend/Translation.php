<?php
namespace MvcCore\Jtl\Controllers\Frontend;

use MvcCore\Jtl\Helpers\Response;
use MvcCore\Jtl\Support\Filesystem\DirectoryComposer;
use JTL\Shop;
use MvcCore\Jtl\Support\Debug\Debugger;
use MvcCore\Jtl\Support\Facades\Localization\Translate;

class Translation
{
    function handle()
    {
        $arrContent = Translate::getTranslations('frontend');
        // Debugger::die_and_dump($arrContent);
        $samrty = Shop::Smarty();
        $samrty->assign ('translations' , $arrContent);
       
    }
}