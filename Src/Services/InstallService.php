<?php

namespace MvcCore\Jtl\Services;

use MvcCore\Jtl\Database\Initialization\Database;
use MvcCore\Jtl\Support\Filesystem\Storage;
use MvcCore\Jtl\Support\Debug\Debugger;
use MvcCore\Jtl\Database\Migrations\DataBaseMigrations;
use MvcCore\Jtl\Database\Seeders\DatabaseSeeder;

class InstallService
{

    private Storage $storage;

    private Database $database;

    private DataBaseMigrations $dataBaseMigrations;

    private DatabaseSeeder $databaseSeeder;

    public function __construct()
    {
        $this->storage = new Storage();
        $this->dataBaseMigrations = new DataBaseMigrations();
        $this->databaseSeeder = new DatabaseSeeder();
        $this->database = new Database();
    }
    /**
     * * it's migrate database tables  and create seeders when plugin installed
     */

    public function install()
    {
        $start = microtime(true);
        
        $this->database->connect();
       
        $this->dataBaseMigrations->up();

        $this->databaseSeeder->run();

        $this->storage->load_resources('Resources', 'objects');
        // $this->storage->load_resources('Resources','alerts');
        $this->storage->load_resources('Resources', 'Photos');
        $end = microtime(true);
        $debugger = new Debugger();
        $time = $end - $start;
        $debugger->log("installed in $time seconds");
    }

    public function unInstall()
    {
        $this->database->connect();
        $this->dataBaseMigrations->down();
        // $this->storage->unload_resources('Resources','alerts');
        $this->storage->unload_resources('Resources', 'Photos');
        $this->storage->unload_resources('Resources', 'objects');
    }
}