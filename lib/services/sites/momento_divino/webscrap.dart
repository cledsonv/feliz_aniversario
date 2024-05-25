import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:feliz_aniversario/pages/components/home_category_data.dart';
import 'package:feliz_aniversario/utils/scraper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MomentoDivinoScraper extends ChangeNotifier {
  Future<List<WebscrapEntity>> fetchImages(
      {required String path, required String name}) async {
    final doc = await Scraper().document('https://www.pensador.com/$path/2/');

    List<String> messages = Scraper.docSelecAll(doc, '.callout p');
    final pagesLength = Scraper.docSelecAll(doc, '.pagination.mb-10.discrete a');

    Logger().i(pagesLength);

    if (name == HomeCategory.mae.name) {
      messages = Scraper.docSelecAll(doc, '.phrases-list p');
      Scraper.removeHtmlElements(messages, 'Nota:');
    }

    final List<WebscrapEntity> entityList = [];
    for (int i = 0; i < messages.length; i++) {
      entityList.add(WebscrapEntity(
        pagesLength: 100,
        url: '',
        content: messages[i],
      ));
    }

    notifyListeners();
    return entityList;
  }
}
