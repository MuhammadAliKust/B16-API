import 'dart:convert';

import 'package:b16_api/models/task.dart';
import 'package:b16_api/models/task_listing.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  String baseURL = "https://todo-nu-plum-19.vercel.app";

  ///Create Task
  Future<TaskModel> createTask({
    required String token,
    required String description,
  }) async {
    http.Response response = await http.post(
      Uri.parse("$baseURL/todos/add"),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
      body: jsonEncode({"description": description}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get All Task
  Future<TaskListingModel> getAllTask(String token) async {
    http.Response response = await http.get(
      Uri.parse("$baseURL/todos/get"),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Search Task
  Future<TaskListingModel> searchTask({
    required String token,
    required String searchKeyword,
  }) async {
    http.Response response = await http.get(
      Uri.parse("$baseURL/todos/search?keywords=$searchKeyword"),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Filter Task
  Future<TaskListingModel> filterTask({
    required String token,
    required String firstDate,
    required String lastDate,
  }) async {
    http.Response response = await http.get(
      Uri.parse("$baseURL/todos/filter?startDate=$firstDate&endDate=$lastDate"),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get Completed Task
  Future<TaskListingModel> getCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse("$baseURL/todos/completed"),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Get InCompleted Task
  Future<TaskListingModel> getInCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse("$baseURL/todos/incomplete"),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Delete Task
  Future<bool> deleteTask({
    required String token,
    required String taskID,
  }) async {
    http.Response response = await http.delete(
      Uri.parse("$baseURL/todos/delete/$taskID"),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  ///Update Task
  Future<bool> updateTask({
    required String token,
    required String taskID,
    required String description,
  }) async {
    http.Response response = await http.patch(
      Uri.parse("$baseURL/todos/update/$taskID"),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
      body: jsonEncode({'description': description}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw response.reasonPhrase.toString();
    }
  }
}
