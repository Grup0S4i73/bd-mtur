import 'package:flutter/material.dart';

class NewUserController {
  static final NewUserController instance = NewUserController._();

  NewUserController._();

  List<String> ufList = ["MA", "CE", "PI", "BA", "GO", "DF", "SP", "RJ", "PB"];
  List<String> cityList = ["São Luís", "Paço do Lumiar", "Raposa", "São José de Ribamar"];
}
