<?php

namespace ox4D\PluginHooks\Hooks;
class PaypalRequest
{
    static function  paypal_request(array $params)
    {
        echo 'paypal request sent successfully';
    }

}