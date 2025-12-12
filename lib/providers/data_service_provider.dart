import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/data_service.dart';

// Провайдер для DataService
final dataServiceProvider = Provider<DataService>((ref) {
  final service = DataService();
  service.initializeDefaultData();
  return service;
});


