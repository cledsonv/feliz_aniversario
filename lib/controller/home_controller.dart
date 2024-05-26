import 'package:feliz_aniversario/entities/category_entity.dart';
import 'package:feliz_aniversario/pages/components/home_category_data.dart'
    as data;
import 'package:logger/logger.dart';

class HomeController {
  final bool alphabeticalOrder;

  List<CategoryEntity> category = [];

  HomeController(this.alphabeticalOrder) {
    category = data.getCategories();

    if (alphabeticalOrder) {
      category.sort((a, b) => a.name.compareTo(b.name));
    } else {
      category.sort((a, b) => b.name.compareTo(a.name));
    }
  }

  searchCategory(String input) {
    final result = category.firstWhere(
      (element) => element.name
          .toLowerCase()
          .trim()
          .contains(input.toLowerCase().trim()),
      orElse: () => category[0],
    );
    Logger().d("Resultado: ${result.name}");
  }
}
