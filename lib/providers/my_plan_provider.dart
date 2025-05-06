import 'package:company_project/models/my_plan_model.dart';
import 'package:company_project/services/api/my_plan_services.dart';
import 'package:flutter/material.dart';

class MyPlanProvider extends ChangeNotifier {
  final MyPlanServices _planService = MyPlanServices();

  SubscribePlanModel? _subscribedPlan;
  bool _isLoading = false;
  String? _error;

  SubscribePlanModel? get subscribedPlan => _subscribedPlan;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMyPlan(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _subscribedPlan = await _planService.fetchUserPlan(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
