import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

class TaskProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  List<Task> get activeTasks => _tasks.where((t) => !t.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((t) => t.isCompleted).toList();
  bool get isLoading => _isLoading;

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getTasks();
      _tasks = (response as List).map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      print('Error loading tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(String title, String description) async {
    try {
      final response = await _apiService.createTask(title, description);
      final newTask = Task.fromJson(response);
      _tasks.insert(0, newTask);
      notifyListeners();
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    try {
      final response = await _apiService.toggleTask(task.id);
      final updatedTask = Task.fromJson(response);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      print('Error toggling task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _apiService.deleteTask(taskId);
      _tasks.removeWhere((t) => t.id == taskId);
      notifyListeners();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  Future<void> incrementPomodoroCount(String taskId) async {
    try {
      final response = await _apiService.incrementPomodoro(taskId);
      final updatedTask = Task.fromJson(response);
      final index = _tasks.indexWhere((t) => t.id == taskId);
      if (index != -1) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      print('Error incrementing pomodoro: $e');
    }
  }
}