<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAddressRequest;
use App\Http\Requests\UpdateAddressRequest;
use App\Models\Address;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class AddressController extends Controller
{
    public function create(StoreAddressRequest $request) {
        $data = $request->validated();
        $user = User::when(['ref' => Arr::get($data, 'user_ref', null)])->first();
        if ($user == null) {
            return Controller::failedResponse('User could not be found!', 404);
        }
        $query = [
            'user_id' => $user->id,
            'country' => Arr::get($data, 'country'),
            'province' => Arr::get($data, 'province', null),
            'city' => Arr::get($data, 'city'),
            'street' => Arr::get($data, 'street', null),
            'full_address' => Arr::get($data, 'full_address', null),
            'postal_code' => Arr::get($data, 'postal_code', null),
            'fax' => Arr::get($data, 'fax', null),
            'fixed_phone' => Arr::get($data, 'fixed_phone', null),
        ];
        $address = Address::create($query);

        $result = [
            'result' => $address,
            'message' => 'Address successfully created'
        ];
        return Controller::successfulResponse($result, 201);
    }

    public function get(Request $request) {
        $data = $request->all();
        $page = (int) Arr::get($data, 'page', Controller::INITIAL_PAGE);
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);
    
        $addresses = Address::forPage($page, $limit)->get();

        $result = [
            'result' => $addresses,
            'page' => $page,
            'count' => $addresses->count(),
            'limit' => $limit,
        ];

        return Controller::successfulResponse($result, 200);
    }

    public function read(Request $request, $id) {
        $address = Address::where(['id' => $id])->get();
        $result = [
            'result' => $address,
        ];
        return Controller::successfulResponse($result);
    }
    public function update(UpdateAddressRequest $request, $id) {
        $data = $request->validated();
        
        $user = User::when(['ref' => Arr::get($data, 'user_ref', null)])->first();
        if ($user == null) {
            return Controller::failedResponse('Update could not be processed, User could not be found!', 404);
        }
        $address = Address::when(['id' => $id, 'user_id' => $user->id])->first();
        if ($address == null) {
            return Controller::failedResponse('Update could not be processed, Address linked to user could not be found!', 404);
        }
        $query = [
            'country' => Arr::get($data, 'country', $address->country),
            'province' => Arr::get($data, 'province', $address->province),
            'city' => Arr::get($data, 'city', $address->city),
            'street' => Arr::get($data, 'street', $address->street),
            'full_address' => Arr::get($data, 'full_address', $address->full_address),
            'postal_code' => Arr::get($data, 'postal_code', $address->postal_code),
            'fax' => Arr::get($data, 'fax', $address->fax),
            'fixed_phone' => Arr::get($data, 'fixed_phone', $address->fixed_phone),
        ];
        $address->update($query);

        $result = [
            'result' => $address,
            'message' => 'Address successfully updated'
        ];
        return Controller::successfulResponse($result, 200);
    }
    public function delete(Request $request, string $id) {
        $address = Address::find($id);
        if ($address == null) {
            return Controller::failedResponse('Address could not be found', 404);
        }
        $address->delete();
        $result = [
            'result' => $id,
            'message' => 'Address deleted successfully'
        ];
        return Controller::successfulResponse($result);
    }
}
