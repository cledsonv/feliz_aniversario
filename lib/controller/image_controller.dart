import 'package:feliz_aniversario/entities/category_entity.dart';
import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:feliz_aniversario/services/sites/momento_divino/webscrap.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageController extends ChangeNotifier {
  final PagingController<int, WebscrapEntity> pagingController =
      PagingController(firstPageKey: 1);
  CategoryEntity? category;
  final _scraper = MomentoDivinoScraper();

  Future<void> init(BuildContext context) async {
    pagingController.addPageRequestListener(_fetch);
    final arguments = ModalRoute.of(context)!.settings.arguments;
    category = arguments as CategoryEntity;
    notifyListeners();
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
          'boa-noite', pageKey.toString(), category!);

      final actuallyPage = pageKey - 1;
      final isLastPage = actuallyPage >= result.first.pagesLength;

      Logger().i(
          'Actually: $actuallyPage, isLast: $isLastPage, total: ${result.first.pagesLength}');

      if (isLastPage) {
        pagingController.appendLastPage(result);
      } else {
        pagingController.appendPage(result, ++pageKey);
      }
    } on Exception catch (e) {
      pagingController.error = e;
      Logger().e(e);
    }
    notifyListeners();
  }

  Future<String?> fetchDescription(String url) async {
    return await _scraper.getDescription(url);
  }

  Future<void> shareImageLink(String imageUrl) async {
    try {
      final url = Uri.parse(imageUrl);
      final response = await http.get(url);
      final bytes = response.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = XFile('${temp.path}/image.jpeg');

      File(path.path).writeAsBytesSync(bytes);

      await Share.shareXFiles([path]);
    } catch (e) {
      Logger().e(e);
    }
  }
}
