<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Http\Requests\UpdateUserRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Schema;

class UserController extends Controller
{
    public function create(Request $request)
    {
        return Controller::failedResponse('This endpoint is still on development. Please use api/v1/auth/register.', 307);
    }

    public function read(Request $request, string $ref)
    {
        $user = User::where(['ref' => $ref])->first();
        if ($user != null && $user->status == 'DELETED') {
            $result = [
                'user' => null,
                'message' => 'This user was deleted.'
            ];
        } else {
            $result = [
                'user' => $user,
            ];
        }

        return Controller::successfulResponse($result, 200);
    }

    public function update(UpdateUserRequest $request, string $ref)
    {
        $user = User::where(['ref' => $ref])->first();

        if ($user == null) {
            return Controller::failedResponse('The user could not be found.', 404);
        }
        $data = $request->validated();
        $query = [
            'firstname' => Arr::get($data, 'firstname'),
            'lastname' => Arr::get($data, 'lastname', $user->lastname),
            'username' => Arr::get($data, 'username', $user->username),
            'phone' => Arr::get($data, 'phone', $user->phone),
            'birthdate' => Arr::get($data, 'birthdate', $user->birthdate),
        ];

        $user->update($query);

        $result = [
            'user' => $user
        ];
        return Controller::successfulResponse($result, 200);
    }

    public function load_identificationFile(Request $request, string $ref)
    {
        $user = User::where(['ref' => $ref])->first();
        if ($user == null) {
            return Controller::failedResponse('User could not be found.', 404);
        }
        if (!$request->hasFile('id_doc')) {
            return Controller::failedResponse('No document could be found.', 400);
        }
        $path = Controller::storeFile($request->file('id_doc'), $user->ref, Controller::IDFilePath);
        $user->id_docs = $path;
        $user->save();

        $result = [
            'message' => 'Successful load ID Doc',
            'doc_path' => $user->path,
        ];
        return Controller::successfulResponse($result, 200);
    }

    public function delete(Request $request, string $ref)
    {
        $user = User::where(['ref' => $ref])->first();
        $user->status = 'DELETED';
        $user->save();

        $result = [
            'delete' => $user->id,
            'message' => 'Deleted successfully'
        ];
        return Controller::successfulResponse($result, 200);
    }

    public function search(Request $request, string $term)
    {
        $data = $request->all();
        $keys = explode(',', Arr::get($data, 'keys'));
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);
        $page = (int) Arr::get($data, 'page', 0);

        $validated = [];
        foreach ($keys as $key) {
            if (Schema::hasColumn('users', $key)) {
                $validated[] = $key;
            }
        }

        $query = 'MATCH (' . implode(',', $validated) . ') AGAINST (? IN BOOLEAN MODE)';

        $users = User::whereRaw($query, ['*' . $term . '*'])->limit($limit)->get();
        $result = [
            'users' => $users,
            'count' => $users->count(),
            'search_term' => $term,
            'limit' => $limit,
            'page' => $page + 1,
        ];
        return Controller::successfulResponse($result, 200);
    }

    public function get(Request $request)
    {
        $data = $request->all();
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);
        $page = (int) Arr::get($data, 'page', 1);

        $users = User::forPage($page, $limit)->get();
        $result = [
            'users' => $users,
            'count' => $users->count(),
            'page' => $page,
            'limit' => $limit,
        ];
        return Controller::successfulResponse($result, 200);
    }
}
