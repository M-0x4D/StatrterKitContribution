<?php

namespace MvcCore\Jtl\Helpers;

class Response
{
    public static function json($data, $statusCode = 200)
    {
        // header('Content-Type: application/json; charset=utf-8');
        http_response_code($statusCode);
        echo json_encode($data);
        exit;
    }
}



// echo json_encode([
//     'status' => $status ,
//     'message' => $message ,
//     'data' => $data
// ] );
// exit;