import 'dart:io';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:todo/network/models/login_request.dart';
import 'package:todo/network/models/login_response.dart';
import 'package:todo/network/models/register_request.dart';
import 'package:todo/network/models/task_model.dart';

part 'todo_api.g.dart';

@RestApi()
abstract class TodoApi {
  factory TodoApi(Dio dio, {String? baseUrl}) = _TodoApi;

  @POST("api/login/")
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST("api/registration/")
  Future<LoginResponse> register(@Body() RegisterRequest request);

  @GET("api/task/")
  Future<List<TaskModel>> getTasks();

  @POST("api/task/")
  Future<TaskModel> addTask(@Body() TaskModel request);

  @PATCH("api/task/{id}/")
  Future<LoginResponse> updateTask(
      @Path("id") String id, @Body() TaskModel request);
}
