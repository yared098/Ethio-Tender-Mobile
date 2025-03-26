import 'package:flutter/material.dart';
import '../models/tender_model.dart';
import '../repository/tender_repository.dart';

class TenderViewModel extends ChangeNotifier {
  final TenderRepository _tenderRepository;
  List<Tender> _tenders = [];

  TenderViewModel(this._tenderRepository);

  List<Tender> get tenders => _tenders;

  Future<void> fetchTenders() async {
    _tenders = await _tenderRepository.getTenders();
    notifyListeners();
  }

  Future<void> addTender(Tender tender) async {
    await _tenderRepository.addTender(tender);
    fetchTenders(); // Refresh list after adding
  }
}
