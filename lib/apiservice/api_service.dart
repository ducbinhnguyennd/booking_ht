import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/auth_result.dart';

class ApiService {
  static final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://10.0.2.2:5000/api/auth'));

  static Future<AuthResult> register(
      String name, String email, String password) async {
    final response = await _dio.post(
      '/register',
      data: FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
      }),
      options: Options(contentType: 'multipart/form-data'),
    );

    final data = response.data;
    return AuthResult(
      token: data['token'],
      user: UserModel.fromJson(data['user']),
    );
  }

  static Future<AuthResult> login(String email, String password) async {
    final response = await _dio.post(
      '/login',
      data: FormData.fromMap({
        'email': email,
        'password': password,
      }),
      options: Options(contentType: 'multipart/form-data'),
    );

    final data = response.data;
    return AuthResult(
      token: data['token'],
      user: UserModel.fromJson(data['user']),
    );
  }
}
