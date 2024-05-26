import 'package:feliz_aniversario/entities/category_entity.dart';
import 'package:feliz_aniversario/pages/components/home_category_data.dart'
    as data;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomeController {
  bool alphabeticalOrder;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<CategoryEntity> category = [];
  List<CategoryEntity> resultCategory = [];

  HomeController(this.alphabeticalOrder) {
    category = data.getCategories();

    if (alphabeticalOrder) {
      category.sort((a, b) => a.name.compareTo(b.name));
    } else {
      category.sort((a, b) => b.name.compareTo(a.name));
    }
    resultCategory = category;
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
