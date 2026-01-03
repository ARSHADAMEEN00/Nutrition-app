import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiClient.client.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Login failed';
    }
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    required int age,
    required String gender,
    required double height,
    required double weight,
  }) async {
    try {
      final response = await _apiClient.client.post(
        ApiConstants.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'age': age,
          'gender': gender,
          'height': height,
          'weight': weight,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Registration failed';
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _apiClient.client.get(ApiConstants.profile);
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to fetch profile';
    }
  }
}
