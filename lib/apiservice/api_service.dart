import 'dart:io';

import 'package:booking_hotel/models/hotel_model.dart';
import 'package:booking_hotel/models/trip_model.dart';
import 'package:booking_hotel/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Platform.isAndroid
    ? 'http://10.0.2.2:5000/api/'
    : 'http://192.168.110.70:5000/api/',
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

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Trip>> getTrips(String status) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found');
      }
      print(token);
      final response = await _dio.get(
        'booking/bookings?trangThai=$status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      List data = response.data;
      return data.map((json) => Trip.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> cancelTrip(String tripId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found');
      }
      await _dio.put(
        'booking/bookings/$tripId/cancel',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
