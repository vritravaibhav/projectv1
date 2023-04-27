import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:projectv1/models/apimodel.dart';

import '../api/api.dart';



class Hsprovider with ChangeNotifier {
  
  // late int x = posts![0].users.length;
  List<String> genderList = List.filled(20, "");
  List<String> ageList = List.filled(20, "");
  List<bool> fill = List.filled(20, false);

  final mybox = Hive.box("mybox");
 

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
    super.addListener(listener);
    notifyListeners();
  }
  


}
