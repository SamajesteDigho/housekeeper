<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;

    const IDFilePath = 'data/id_documents/';
    const SEARCH_LIMIT = 10;
    const INITIAL_PAGE = 1;

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
        ], 200);
    }

    public static function storeFile($file, $name, $folder) {
        if (isset($file)) {
            $filename = $name . "." . $file->extension();
            $file->move(public_path($folder), $filename);
            return $folder . $filename;
        }
        return null;
    }

    public static function userRefGen($length = 16)
    {
        return 'U' . Str::uuid();
    }

    public static function housekeeperRefGen($length = 7)
    {
        $pool = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $code = substr(str_shuffle(str_repeat($pool, $length)), 0, $length);
        return "HK" . $code;
    }

    public static function taskRefGen()
    {
        return 'T' . Str::uuid();
    }

    public static function validateFilters(string $table, string $filters = null): string|null {
        if ($filters == null) {
            return null;
        }
        $keys = explode(',', $filters);
        $validated = [];
        foreach ($keys as $key) {
            if (Schema::hasColumn($table, $key)) {
                $validated[] = $key;
            }
        }
        $result = implode(',', $validated);
        return $result;
    }
}
