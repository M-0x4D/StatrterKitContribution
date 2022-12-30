<?php

use ox4D\cli\Controllers\ResourceController;
use ox4D\cli\Migrations\CreateMigration;
use MvcCore\Jtl\Controllers\Frontend\Test;

use ox4D\cli\Migrations\migrate;


return [

    'HOOK_1' => [],
    'HOOK_CREATE_RESOURCE' =>[Test::class,'calculateSquares'],

];