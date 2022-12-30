<?php

namespace ox4D\cli\Controllers;

class ResourceController
{
    /***
     * 
     * file name property
     */
    protected static $fileName;

    public static function runCommand($fileName)
    {
        $dir = __DIR__ . '/../../Src/Controllers/Admin/';
        self::$fileName = $dir.$fileName;
        $interfaceFile = "$dir/ICrud.php";
        if (!file_exists($interfaceFile)) {
            $myfile = fopen($interfaceFile, "w") or die("Unable to create interface!");
        $request='$'.'request';
        $txt = "<?php

namespace MvcCore\Jtl\Controllers\Admin;

use MvcCore\Jtl\Support\Http\Request;



    interface ICrud
    {

        /***
         * 
         * index function
         */
        public function index();
        /***
         * 
         * create function
         */
        public function create(Request $request);

        /***
         * 
         * update function
         */
        public function update(Request $request);

        /***
         * 
         * destroy function
         */
        public function destroy(Request $request);

    }";
        fwrite($myfile, $txt);
        fclose($myfile);
        echo "Icrud interface created successfully\n";
        }
        $myfile = fopen(self::$fileName.".php", "w") or die("Unable to create resource!");
        $request = '$' . 'request';
        $txt = "<?php
namespace ox4D\cli\make;


use MvcCore\Jtl\Support\Debug\Debugger;
use MvcCore\Jtl\Controllers\Admin\ICrud;
use MvcCore\Jtl\Helpers\Response;
use MvcCore\Jtl\Support\Http\Request;
use JTL\Shop;
   
    class $fileName implements ICrud
    {
        public function index()
        {

        }
    
    
        public function create(Request $request)
        {
        }
    
    
        public function update(Request $request)
        {
        }
    
    
        public function destroy(Request $request)
        {
        }
        
        }";
        fwrite($myfile, $txt);
        fclose($myfile);
        echo "[+] $fileName Resource Controller File created successfully!\n";

    }
}
