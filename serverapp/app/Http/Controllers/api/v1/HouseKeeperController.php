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

    /*====================================================================
        SPECIALIZED ENDPOINTS
    ====================================================================*/
    public function top_keepers(Request $request) {
        $data = $request->all();
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);
        $page = (int) Arr::get($data, 'page', Controller::INITIAL_PAGE);
        $keepers = Housekeeper::orderBy('rating', 'desc')->take($limit)->get();

        $user_keeper = [];

        foreach ($keepers as $keep) {
            $user = User::find($keep->user_id);
            $user_keeper[] = Housekeeper::process_user_keeper($keep, $user);
        }
        $result = [
            'result' => $user_keeper,
            'count' => count($user_keeper),
            'page' => $page,
            'limit' => $limit
        ];
        return Controller::successfulResponse($result);
    }
    
    public function near_keepers(Request $request) {
        $data = $request->all();
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);
        $page = (int) Arr::get($data, 'page', Controller::INITIAL_PAGE);
        $keepers = Housekeeper::inRandomOrder()->orderBy('rating', 'desc')->take($limit)->get();

        $user_keeper = [];

        foreach ($keepers as $keep) {
            $user = User::find($keep->user_id);
            $user_keeper[] = Housekeeper::process_user_keeper($keep, $user);
        }
        $result = [
            'result' => $user_keeper,
            'count' => count($user_keeper),
            'page' => $page,
            'limit' => $limit
        ];
        return Controller::successfulResponse($result);
    }

    public function search_keepers(Request $request) {
        $data = $request->all();
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);
        $page = (int) Arr::get($data, 'page', Controller::INITIAL_PAGE);

        $searchTerm = Arr::get($data, 'searchTerm', null);
        $keywords = Arr::get($data, 'filter', null);

        if ($searchTerm == null) {
            $users = User::inRandomOrder()->get();
        } else {
            $filters = Controller::validateFilters('users', $keywords);
            if ($filters == null) {
                $query = 'MATCH (firstname,lastname,email) AGAINST (? IN BOOLEAN MODE)';
            } else {
                $query = 'MATCH (' . $filters . ') AGAINST (? IN BOOLEAN MODE)';
            }
            $users = User::where('status', '!=', 'DELETED')->whereRaw($query, ['*' . $searchTerm . '*'])->get();
        }

        $user_keeper = [];
        foreach ($users as $usr) {
            $keeper = Housekeeper::where(['user_id'=> $usr->id])->first();
            if ($keeper != null) {
                $user_keeper[] = Housekeeper::process_user_keeper($keeper, $usr);
            }
        }
        $answer = array_slice($user_keeper, 0, $limit);
        $result = [
            'result' => $answer,
            'count' => count($answer),
            'page' => $page,
            'limit' => $limit
        ];
        return Controller::successfulResponse($result);
    }
}
