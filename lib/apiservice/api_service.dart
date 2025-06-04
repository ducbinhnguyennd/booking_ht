import 'package:booking_hotel/models/hotel_model.dart';
import 'package:booking_hotel/models/user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:5000/api/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<LoginResponse> register(
      String name, String email, String password) async {
    try {
      final response = await _dio.post(
        'auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getUserProfile(String token) async {
    try {
      final response = await _dio.get(
        'auth/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getUserById(String token, String userId) async {
    try {
      final response = await _dio.get(
        'auth/users/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      return e.response!.data['msg'] ?? 'Đã có lỗi xảy ra';
    } else {
      return 'Không thể kết nối đến server';
    }
  }

  Future<List<Hotel>> fetchHotels(String filter) async {
    try {
      final response = await _dio.get('/hotel?filter=$filter');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Hotel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load hotels');
      }
    } catch (e) {
      throw Exception('Error fetching hotels: $e');
    }
  }
}
