import 'package:company_project/models/chemical_model.dart';
import 'package:company_project/services/api/chemical_services.dart';
import 'package:flutter/material.dart';

class ChemicalProvider extends ChangeNotifier {
  final ChemicalServices _services = ChemicalServices();

  List<ChemicalModel> _chemical = [];
  bool _isLoading = false;
  String? _error;

  List<ChemicalModel> get chemical => _chemical;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchChemicals() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _chemical = await _services.fetchChemicals();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
