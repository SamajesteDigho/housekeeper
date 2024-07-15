<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreHouseKeeperRequest;
use App\Http\Requests\UpdateHouseKeeperRequest;
use App\Models\Housekeeper;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class HouseKeeperController extends Controller
{
    public function get(Request $request) {
        $data = $request->all();
        $page = (int) Arr::get($data, 'page', Controller::INITIAL_PAGE);
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);
    
        $keepers = Housekeeper::forPage($page, $limit)->get();

        $result = [
            'result' => $keepers,
            'page' => $page,
            'count' => $keepers->count(),
            'limit' => $limit,
        ];

        return Controller::successfulResponse($result, 200);
    }
    public function create(StoreHouseKeeperRequest $request) {
        $data = $request->validated();
        $user = User::where(['ref' => Arr::get($data, 'user_ref')])->first();

        $query = [
            'user_id' => $user->id,
            'matricule' => Controller::housekeeperRefGen(),
            'nationality' => Arr::get($data, 'nationality', null),
            'province' => Arr::get($data, 'province', null),
            'religion' => Arr::get($data, 'religion', null),
        ];

        $housekeeper = Housekeeper::create($query);

        $result = [
            'result' => $housekeeper,
            'message' => 'House keeper created successfully. Verification in progress'
        ];
        return Controller::successfulResponse($result);
    }
    public function read(Request $request, $id) {
        $housekeeper = Housekeeper::find($id);
        
        if ($housekeeper != null) {
            $user = User::find($housekeeper->user_id);
            if ($user != null) {
                $user['keeper'] = $housekeeper;
            }
        }

        $result = [
            'result' => $user ?? null,
        ];
        return Controller::successfulResponse($result);
    }
    public function update(UpdateHouseKeeperRequest $request, $id) {
        $housekeeper = Housekeeper::find($id);
        if ($housekeeper == null) {
            return Controller::failedResponse('Could not find the housekeeper');
        }
        $data = $request->validated();
        $query = [
            'nationality' => Arr::get($data, 'nationality', $housekeeper->nationality),
            'province' => Arr::get($data, 'province', $housekeeper->province),
            'religion' => Arr::get($data, 'religion', $housekeeper->religion),
        ];

        $housekeeper->update($query);
        $result = [
            'result' => $housekeeper,
            'message' => 'Updated successfully'
        ];
        return Controller::successfulResponse($result);
    }
    public function delete(Request $request, $id) {
        $housekeeper = Housekeeper::find($id);
        if ($housekeeper == null) {
            return Controller::failedResponse('Could not find the housekeeper to delete');
        }
        $housekeeper->delete();
        $result = [
            'result' => $id,
            'message' => 'Housekeepr deleted successfully'
        ];
        return Controller::successfulResponse($result);
    }
}
