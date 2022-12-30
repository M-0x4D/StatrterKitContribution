<?php

namespace MvcCore\Jtl\Database\Migrations;

use MvcCore\Jtl\Database\Initialization\Migration;
        
    class DataBaseMigrations extends Migration
    {
        public function up()
        {
                $this->call([
    
            ], 'up'); 
        }
    
    
        public function upExtention()
        {
            $this->call([
                
            ], 'up');
        }
    
        public function down()
        {
            $this->call([

    
            ], 'down');
        }
    
    
        public function downExtention()
        {
            $this->call([

            ], 'down');
            
        }
    }