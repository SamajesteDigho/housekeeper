<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Str;

class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;

    const IDFilePath = 'data/id_documents/';
    const SEARCH_LIMIT = 10;

    public static function successfulResponse($data, int $status = 200)
    {
        return response()->json([
            'data' => $data,
            'status_code' => $status,
            'success' => true
        ], $status);
    }

    public static function failedResponse($message, int $status = 404)
    {
        return response()->json([
            'message' => $message,
            'status_code' => $status,
            'success' => false
        ], $status);
    }

    public static function storeFile($file, $name, $folder) {
        if (isset($file)) {
            $filename = $name . "." . $file->extension();
            $file->move(public_path($folder), $filename);
            return $filename;
        }
        return null;
    }

    public static function userRefGen($length = 16)
    {
        return 'U' . Str::uuid();
    }

    public static function housekeeperRefGen($length = 10)
    {
        $pool = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $code = substr(str_shuffle(str_repeat($pool, $length)), 0, $length);
        return "HK$code";
    }

    public static function taskRefGen()
    {
        return 'T' . Str::uuid();
    }
}
