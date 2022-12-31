<?php

use ox4D\cli\Controllers\ResourceController;
use ox4D\cli\Migrations\CreateMigration;
use MvcCore\Jtl\Controllers\Frontend\Test;
use ox4D\PluginHooks\Hooks\PaypalRequest;
use ox4D\cli\Migrations\migrate;


return [

    PAYPALREQUEST => [PaypalRequest::class, 'paypal_request'],

];
