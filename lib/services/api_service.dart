import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.19.215:5000/api '; // Use your IP for emulator
  
  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Auth endpoints
  Future<Map<String, dynamic>> register(String email, String password, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    return json.decode(response.body);
  }

  // Task endpoints
  Future<dynamic> getTasks() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks'),
      headers: await _getHeaders(),
    );
    return json.decode(response.body);
  }

  Future<dynamic> createTask(String title, String description) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: await _getHeaders(),
      body: json.encode({
        'title': title,
        'description': description,
      }),
    );
    return json.decode(response.body);
  }

  Future<dynamic> updateTask(String taskId, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$taskId'),
      headers: await _getHeaders(),
      body: json.encode(data),
    );
    return json.decode(response.body);
  }

  Future<void> deleteTask(String taskId) async {
    await http.delete(
      Uri.parse('$baseUrl/tasks/$taskId'),
      headers: await _getHeaders(),
    );
  }

  Future<dynamic> toggleTask(String taskId) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/tasks/$taskId/toggle'),
      headers: await _getHeaders(),
    );
    return json.decode(response.body);
  }

  Future<dynamic> incrementPomodoro(String taskId) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/tasks/$taskId/increment'),
      headers: await _getHeaders(),
    );
    return json.decode(response.body);
  }

  // Statistics endpoints
  Future<dynamic> getTodayStats() async {
    final response = await http.get(
      Uri.parse('$baseUrl/statistics/today'),
      headers: await _getHeaders(),
    );
    return json.decode(response.body);
  }

  Future<dynamic> getWeekStats() async {
    final response = await http.get(
      Uri.parse('$baseUrl/statistics/week'),
      headers: await _getHeaders(),
    );
    return json.decode(response.body);
  }

  Future<dynamic> getStreakInfo() async {
    final response = await http.get(
      Uri.parse('$baseUrl/statistics/streak'),
      headers: await _getHeaders(),
    );
    return json.decode(response.body);
  }
}