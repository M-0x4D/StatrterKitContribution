<?php

namespace MvcCore\Jtl\Services;


use MvcCore\Jtl\Support\Route;
use MvcCore\Jtl\Support\Http\Request;
use MvcCore\Jtl\Database\Initialization\Database;
use MvcCore\Jtl\Support\Debug\Debugger;
use MvcCore\Jtl\Controllers\Frontend\Translation;

class RoutesService
{

    private Database $database;

    public function __construct()
    {
        $this->database = new Database();
        $this->database->connect();
    }


    public function frontend_executions()
    {
        
    }


    public function backend_executions()
    {

    }

    public function backend_endpoints()
    {
        /* routes */
        Route::group(['VerifyCsrfToken'], function () {

           
        });

        Route::resolveApi(Request::uri(), Request::type());
    }

    public function frontend_endpoints()
    {

        Route::group([''], function () {
           
        });
        //               route [endpoint]   type [post-get-put]
        Route::resolveApi(Request::uri(), Request::type());
    }

    function frontend_process()
    {
        
        try {
            Route::resolve(Request::uri(), Request::type());
        } catch (RouteNotFoundException $exception) {
            return Response::json(['message' => $exception->getMessage()], 404);
        } catch (DatabaseQueryException $exception) {
            return Response::json(['message' => $exception->getMessage()], 422);
        }
    }
}
