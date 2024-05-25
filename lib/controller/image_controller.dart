import 'package:feliz_aniversario/entities/category_entity.dart';
import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:feliz_aniversario/services/sites/momento_divino/webscrap.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class ImageController extends ChangeNotifier {
  final PagingController<int, WebscrapEntity> pagingController =
      PagingController(firstPageKey: 1);
  final _scraper = MomentoDivinoScraper();
  CategoryEntity? category;

  Future<void> init(BuildContext context) async {
    pagingController.addPageRequestListener(_fetch);
    final arguments = ModalRoute.of(context)!.settings.arguments;

    category = arguments as CategoryEntity;
    getPageName();

    pagingController.notifyListeners();
    notifyListeners();
  }

  String getPageName() {
    final String? name = category?.name;
    return name != null ? 'Feliz Aniversário, $name!' : '';
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }

  Future<void> _fetch(int pageKey) async {
    try {
      if (pageKey == 1) {
        notifyListeners();
      }
      final result = await _scraper.fetchImages(
          path: category!.path, page: pageKey, name: category!.name);

      final actuallyPage = pageKey - 1;
      final isLastPage = actuallyPage >= result.first.pagesLength;

      if (isLastPage) {
        pagingController.appendLastPage(result);
      } else {
        pagingController.appendPage(result, ++pageKey);
      }
      Logger().i(
          'Actually: $actuallyPage, isLast: $isLastPage, total: ${result.first.pagesLength}');
    } on Exception catch (e) {
      pagingController.error = e;
      Logger().e(e);
      rethrow;
    }
    notifyListeners();
  }
}
