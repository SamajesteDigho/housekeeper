<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreHouseKeeperRequest;
use App\Http\Requests\UpdateHouseKeeperRequest;
use App\Models\Address;
use App\Models\Housekeeper;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class HouseKeeperController extends Controller
{
    public function get(Request $request)
    {
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

    public function create(StoreHouseKeeperRequest $request)
    {
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

    public function read(Request $request, $id)
    {
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

    public function update(UpdateHouseKeeperRequest $request, $id)
    {
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

    public function delete(Request $request, $id)
    {
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
    public function top_keepers(Request $request)
    {
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

    public function near_keepers(Request $request)
    {
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

    public function search_keepers(Request $request)
    {
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
            $keeper = Housekeeper::where(['user_id' => $usr->id])->first();
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

    public function new_keeper(Request $request, $user_ref)
    {
        $data = $request->all();
        $firstname = Arr::get($data, 'firstname');
        $lastname = Arr::get($data, 'lastname');
        // $email = Arr::get($data, 'email');
        $phone = Arr::get($data, 'phone');
        $birthdate = Arr::get($data, 'birthdate');
        $nationality = Arr::get($data, 'nationality');
        $province = Arr::get($data, 'province');
        $religion = Arr::get($data, 'religion');
        $country = Arr::get($data, 'country');
        $province_res = Arr::get($data, 'province_res');
        $city_res = Arr::get($data, 'city');
        $full_address = Arr::get($data, 'full_address');
        $fax = Arr::get($data, 'fax');
        $postal_code = Arr::get($data, 'postal_code');

        $user = User::where(['ref' => $user_ref])->first();
        if ($user == null) {
            return Controller::failedResponse('User could not be found');
        }

        if ($request->hasFile('id_doc')) {
            $path = Controller::storeFile($request->file('id_doc'), $user_ref, Controller::IDFilePath);
        } else {
            Controller::failedResponse("Could not find the id file");
        }

        $user->update([
            'firstname' => $firstname ?? $user->firstname,
            'lastname' => $lastname ?? $user->lastname,
            'phone' => $phone ?? $user->phone,
            'birthdate' => $birthdate ?? $user->birthdate,
            'id_docs' => $path,
            'role' => "HOUSEKEEPER",
            'status' => 'ACTIF'
        ]);

        $housekeeper = Housekeeper::where(['user_id' => $user->id])->first();
        if ($housekeeper == null) {
            Housekeeper::create([
                'user_id' => $user->id,
                'matricule' => Controller::housekeeperRefGen(),
                'nationality' => $nationality,
                'province' => $province,
                'religion' => $religion,
                'verified' => true
            ]);
        } else {
            $housekeeper->update([
                'nationality' => $nationality ?? $housekeeper->nationality,
                'province' => $province ?? $housekeeper->province,
                'religion' => $religion ?? $housekeeper->religion,
                'verified' => true
            ]);
        }

        $address = Address::where(['user_id' => $user->id])->first();
        if ($address == null) {
            Address::create([
                'user_id' => $user->id,
                'country' => $country,
                'province' => $province_res,
                'city' => $city_res,
                'full_address' => $full_address,
                'postal_code' => $postal_code,
                'fax' => $fax
            ]);
        } else {
            $address->update([
                'country' => $country ?? $address->country,
                'province' => $province_res ?? $address->province,
                'city' => $city_res ?? $address->city,
                'full_address' => $full_address ?? $address->full_address,
                'postal_code' => $postal_code ?? $address->postal_code,
                'fax' => $fax ?? $address->fax
            ]);
        }
        
        $result = [
            'result' => User::parse_user($user),
            'message' => 'HouseKeeper demande processed'
        ];
        return Controller::successfulResponse($result);
    }
}
