import 'package:feliz_aniversario/entities/category_entity.dart';
import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:feliz_aniversario/utils/scraper.dart';
import 'package:flutter/material.dart';

class MomentoDivinoScraper extends ChangeNotifier {
  Future<List<WebscrapEntity>> fetchImages(
      String path, String offset, CategoryEntity category) async {
    final doc = await Scraper()
        .document('https://www.momentodivino.com.br/${category.path}_$offset/');

    final images = Scraper.docSelecAllAttr(
        doc, '.main-content.col-sx-12.col-sm-12.col-md-12.col-lg-8 img', 'src');
    final pageSize = Scraper.docSelecAll(doc, '.pagination.pagination-lg a');
    final urls =
        Scraper.docSelecAllAttr(doc, '.entry-header.clearfix a', 'href');

    final List<WebscrapEntity> entityList = [];
    for (int i = 0; i < images.length; i++) {
      entityList.add(WebscrapEntity(
        images: images[i],
        pagesLength: int.parse(pageSize.last),
        url: urls[i],
      ));
    }
    notifyListeners();
    return entityList;
  }

  Future<String?> getDescription(String url) async {
    final doc = await Scraper().document(url);
    final content = doc.getElementById('descricao')?.text;
    return content;
  }
}
