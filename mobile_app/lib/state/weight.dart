import 'package:flutter/cupertino.dart';
import 'package:mobile_app/models/weight/base.dart';
import 'package:mobile_app/models/weight/delete.dart';
import 'package:mobile_app/models/weight/get.dart';
import 'package:mobile_app/models/weight/weight.dart';
import 'package:mobile_app/services/weights.dart';

class WeightProvider extends ChangeNotifier {
  final WeightApiService weightApiService;

  WeightProvider({required this.weightApiService});

  List<Weight> weights = [];

  bool isLoading = false;
  bool isCreateUpdate = false;
  String createUpdateMessage = '';

  loadAll() async {
    isLoading = true;
    GetWeightResponse response = await weightApiService.load();
    if (response.status == 200) {
      weights.addAll(response.result!);
      weights.sort((a, b) => b.date.compareTo(a.date));
    }
    isLoading = false;
    notifyListeners();
  }

  remove(Weight weight) async {
    DeleteWeightResponse response = await weightApiService.delete(weight.id);
    if (response.status == 200) {
      weights.removeWhere((element) => element.id == weight.id);
      weights.sort((a, b) => b.date.compareTo(a.date));
    }

    notifyListeners();
  }

  add(String value) async {
    isCreateUpdate = true;
    notifyListeners();

    BaseWeightResponse response = await weightApiService.create(value);

    if (response.status == 201) {
      weights.add(response.result!);
      weights.sort((a, b) => b.date.compareTo(a.date));
    } else {
      createUpdateMessage = response.message!;
    }
    isCreateUpdate = false;

    notifyListeners();
  }

  update(String id, String value) async {
    isCreateUpdate = true;
    notifyListeners();

    BaseWeightResponse response = await weightApiService.update(id, value);
    if (response.status == 200) {
      weights.removeWhere((element) => element.id == id);
      weights.add(response.result!);
      weights.sort((a, b) => b.date.compareTo(a.date));
    } else {
      createUpdateMessage = response.message!;
    }
    isCreateUpdate = false;

    notifyListeners();
  }
}
