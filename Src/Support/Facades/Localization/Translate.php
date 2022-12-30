<?php

namespace MvcCore\Jtl\Support\Facades\Localization;

use MvcCore\Jtl\Support\Facades\Filesystem\DirectoryComposer;
use MvcCore\Jtl\Support\Debug\Debugger;
use MvcCore\Jtl\Helpers\Response;



class Translate
{
    public static function translate($fileName, $key): string
    {
        $lang = Lang::get();
        $directoryComposer = new DirectoryComposer();
        $fileName = file_get_contents("{$directoryComposer->plugin_root()}/Src/Langs/{$lang}/{$fileName}.json");
        $fileArr = json_decode($fileName , true);
         return $fileArr[$key];
    }

    public static function getTranslations($fileName): array
    {
        $lang = Lang::get();
        $directoryComposer = new DirectoryComposer();
        $fileContent = file_get_contents("{$directoryComposer->plugin_root()}/Src/Langs/{$lang}/{$fileName}.json");
        $fileArr = json_decode($fileContent , true);
        return $fileArr;
    }

    public function setValue($lang, $fileNameReuest, $key, $newValue)
    {
        $directoryComposer = new DirectoryComposer();
        $fileName = file_get_contents("{$directoryComposer->plugin_root()}/Src/Langs/{$lang}/{$fileNameReuest}.json");
        $fileName = json_decode($fileName, true);
        if (array_key_exists($key, $fileName)) {
            $fileName[$key] = $newValue;
            $decoded = json_encode($fileName);
            file_put_contents("{$directoryComposer->plugin_root()}/Src/Langs/{$lang}/{$fileNameReuest}.json", $decoded);
        }
        return $fileName;
    }
}
