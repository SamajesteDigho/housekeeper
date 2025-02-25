<?php

namespace App\Http\Controllers\api\v1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreTaskRequest;
use App\Http\Requests\UpdateTaskRequest;
use App\Models\Housekeeper;
use App\Models\Task;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class TaskController extends Controller
{
    public function get(Request $request)
    {
        $data = $request->all();
        $page = (int) Arr::get($data, 'page', Controller::INITIAL_PAGE);
        $limit = (int) Arr::get($data, 'limit', Controller::SEARCH_LIMIT);

        $tasks = Task::forPage($page, $limit)->get();

        $result = [
            'result' => $tasks,
            'page' => $page,
            'count' => $tasks->count(),
            'limit' => $limit,
        ];
        return Controller::successfulResponse($result, 200);
    }
    public function create(Request $request)
    {
        $data = $request->all();
        if (Arr::get($data, 'client_ref') == Arr::get($data, 'keeper_ref')) {
            return Controller::failedResponse('Client cannot be Keeper on a given task.');
        }
        $client = User::where(['ref' => Arr::get($data, 'client_ref')])->where('status', '!=', 'DELETED')->first();
        $keeper = User::where(['ref' => Arr::get($data, 'keeper_ref')])->where('status', '!=', 'DELETED')->first();
        if ($client == null || $keeper == null) {
            return Controller::failedResponse('Client or Keeper unable to find.');
        }
        $keep_ref = Housekeeper::where(['user_id' => $keeper->id])->first();
        if ($keep_ref == null) {
            return Controller::failedResponse('Could not associate the keeper address to a keeper function. Please check entries.');
        }
        $query = [
            'ref' => Controller::taskRefGen(),
            'client_id' => $client->id,
            'keeper_id' => $keeper->id,
            'description' => Arr::get($data, 'description', null),
            'start' => Arr::get($data, 'start', null),
            'end' => Arr::get($data, 'end', null),
            'price_per_hour' => Arr::get($data, 'price_per_hour', 0),
            'currency' => Arr::get($data, 'currency', null),
            'reduction' => Arr::get($data, 'reduction', 0),
            'status' => 'PENDING',
        ];
        $task = Task::create($query);
        $result = [
            'result' => Task::parse_task($task),
            'message' => 'Task created successfully'
        ];
        return Controller::successfulResponse($result, 201);
    }
    public function read(Request $request, $id)
    {
        $task = Task::find($id);
        $result = [
            'result' => $task
        ];
        return Controller::successfulResponse($result);
    }
    public function update(UpdateTaskRequest $request, $id)
    {
        $task = Task::find($id);
        if ($task == null) {
            return Controller::failedResponse('Could not find the task.');
        }
        $data = $request->validated();
        $client = User::where(['ref' => Arr::get($data, 'client_ref')])->first();
        $keeper = User::where(['ref' => Arr::get($data, 'keeper_ref')])->first();
        if ($client == null || $keeper == null) {
            return Controller::failedResponse('Client or Keeper unable to find.');
        }
        $query = [
            'description' => Arr::get($data, 'description', $task->description),
            'start' => Arr::get($data, 'start', $task->start),
            'end' => Arr::get($data, 'end', $task->end),
            'price_per_hour' => Arr::get($data, 'price', $task->price_per_hour),
            'currency' => Arr::get($data, 'currency', $task->currency),
            'reduction' => Arr::get($data, 'reduction', $task->currency),
        ];

        $task->update($query);
        $result = [
            'result' => $task,
            'message' => 'Successfully updated the task'
        ];
        return Controller::successfulResponse($result);
    }
    public function delete(Request $request, $id)
    {
        $task = Task::find($id);
        if ($task == null) {
            return Controller::failedResponse('The task could not be found');
        }
        $task->delete();
        $result = [
            'result' => $id,
            'message' => 'Task deleted successfully.'
        ];
        return Controller::successfulResponse($result);
    }

    public function user_tasks(Request $request, string $user_ref)
    {
        $user = User::where(['ref' => $user_ref])->first();
        $tasks = [];
        if ($user == null) {
            $tasks = [];
        } else {
            $collected = Task::where(['keeper_id' => $user->id])->orWhere(['client_id' => $user->id])->get();
            foreach ($collected as $task) {
                $tasks[] = Task::parse_task($task);
            }
        }

        $result = [
            'result' => $tasks,
            'count' => count($tasks)
        ];
        return Controller::successfulResponse($result);
    }

    public static function set_status(Request $request)
    {
        $data = $request->all();
        $task_ref = Arr::get($data, 'task_ref');
        $status = Arr::get($data, 'status');

        $task = Task::where(['ref' => $task_ref])->first();
        if ($task == null) {
            return Controller::failedResponse('Could not locate the task');
        }
        $task->update(['status' => $status]);
        $result = [
            'result' => Task::parse_task($task),
            'status_set' => true
        ];
        return Controller::successfulResponse($result);
    }

    public static function appreciate(Request $request)
    {
        $data = $request->all();
        $task_ref = Arr::get($data, 'task_ref');
        $rating = doubleval(Arr::get($data, 'rating'));
        $appreciation = Arr::get($data, 'appreciation');

        $task = Task::where(['ref' => $task_ref])->first();
        if ($task == null) {
            return Controller::failedResponse('Could not locate the task');
        }
        $task->update(['appreciation' => $appreciation, 'rating' => $rating]);
        $result = [
            'result' => Task::parse_task($task),
            'status_set' => true
        ];
        return Controller::successfulResponse($result);
    }
}
