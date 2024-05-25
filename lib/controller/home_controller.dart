import 'package:feliz_aniversario/entities/category_entity.dart';
import 'package:feliz_aniversario/pages/components/home_category_data.dart'
    as data;

class HomeController {
  List<CategoryEntity> category = [];

  HomeController() {
    category = data.categories;
  }
}
