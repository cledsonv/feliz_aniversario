import 'package:feliz_aniversario/entities/category_entity.dart';
import 'package:feliz_aniversario/pages/components/home_category_data.dart'
    as data;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomeController {
  bool alphabeticalOrder = true;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<CategoryEntity> category = [];
  List<CategoryEntity> resultCategory = [];

  Future<void> init() async {
    category = data.getCategories();
    resultCategory = category;
    organizeList();
  }

  void organizeList() {
    if (alphabeticalOrder) {
      resultCategory.sort((a, b) => a.name.compareTo(b.name));
    } else {
      resultCategory.sort((a, b) => b.name.compareTo(a.name));
    }
  }

  searchCategory(String input) {
    resultCategory = category
        .where(
          (element) => element.name
              .toLowerCase()
              .trim()
              .contains(input.toLowerCase().trim()),
        )
        .toList();
    Logger().d("Resultado: $resultCategory");
  }
}
