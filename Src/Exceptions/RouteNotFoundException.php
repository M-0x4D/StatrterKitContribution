<?php

namespace MvcCore\Jtl\Exceptions;

class RouteNotFoundException extends \Exception
{
    protected $message = "This route is not found";
}
