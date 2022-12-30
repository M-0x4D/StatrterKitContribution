<?php

namespace ox4D\cli\Migrations;

use MvcCore\Jtl\Database\Migrations\DataBaseMigrations;
class migrate
{

    public static function create()
    {

        exec('c:\WINDOWS\system32\cmd.exe /c START '.__DIR__.'\sshConnect.bat');
        // $migration = new DataBaseMigrations();
        // $migration->upExtention();
        echo ' [+] Migration Created Successfully!';
    }


    function update($fileName)
    {

    }

    function delete()
    {
        $migration = new DataBaseMigrations();
        $migration->downExtention();

    }
}