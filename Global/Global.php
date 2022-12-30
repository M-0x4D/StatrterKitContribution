<?php

use MvcCore\Jtl\Support\Facades\Filesystem\DirectoryComposer;
use MvcCore\Jtl\Support\Facades\Configs\Configs;
/**
 * for executeHook function
 */
// require PFAD_ROOT . PFAD_INCLUDES . 'bestellabschluss_inc.php';




/**
 * Global variables and constants
 * 
 */
define('TESTGLOBAL', 'testGlobalValue');







/**
 * read data from .env file
 * 
 * @param string $key
 * @return string|null
 */
function env($key): string
{
    $directoryComposer = new DirectoryComposer();
    $lines  = file("{$directoryComposer->plugin_root()}/.env");
    $keys   = [];
    $values = [];
    foreach ($lines as $line) {
        $line = trim($line);
        if ($line === PHP_EOL || stripos($line, '#') === 0) {
            continue;
        }
        if (stripos($line, PHP_EOL)) {
            [$line,] = explode(PHP_EOL, $line);
        }
        [$keys[], $values[]] = explode('=', $line);
    }
    $configs = array_combine($keys, $values);
    if (array_key_exists($key, $configs)) {
        return $configs[$key];
    }
    return NULL;
}

/**
 * set key&value data into .env file
 * 
 * @param string $key
 * @param string $value
 */
function config($key, $value): void
{
    $directoryComposer = new DirectoryComposer();
    $configs[$key] = $value;
}

/**
 * check if key exists in .env file or not
 * 
 * @param string $key
 * @return boolean $value
 */
function checkEnvKey($key)
{
}


/**
 * 
 */
function arrayToJson(array $arrData): string
{
    $jsonData =  json_encode($arrData);
    return $jsonData;
}



/**
 * 
 */
function paypalUrlFromEnv()
{
    $configs = new Configs();
    $paypalMode = isset($configs->get_configs()['PAYPAL_MODE']) ? $configs->get_configs()['PAYPAL_MODE'] : false;
    $paypalBaseUrl = $configs->get_configs()[$paypalMode];
    return $paypalBaseUrl;
}


/**
 * execute plugin hook system using this function
 * 
 * @param string $HOOK.
 * @param array $params
 * @return void
 */
function executePluginHook(string $HOOK, array $params)
{
    $Hooks = require_once __DIR__ . '/../PluginHook/HOOKS.php';
    foreach ($Hooks as $hook => $action) {
        if ($hook === $HOOK) {
            $method = $action[1];
            $action[0]::$method($params);
        }
    }
}
