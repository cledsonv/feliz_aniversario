import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:feliz_aniversario/utils/scraper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';

class MomentoDivinoScraper extends ChangeNotifier {
  Future<List<WebscrapEntity>> fetchImages(
      {required String path, required page, required String name}) async {
    Document? doc;
    if (page == 1) {
      doc = await Scraper().document('https://www.pensador.com/$path');
    } else {
      doc = await Scraper().document('https://www.pensador.com/$path/$page/');
    }

    List<String> messages = Scraper.docSelecAll(doc, '.callout p');
    List<String> pagesLength = Scraper.docSelecAll(doc, '#paginacao a');

    if (messages.isEmpty) {
      messages = Scraper.docSelecAll(doc, '.phrases-list p');
      Scraper.removeHtmlElements(messages, 'Nota:');
    }

    if (pagesLength.isEmpty) {
      pagesLength = ['0'];
    }

    List<int?> pageNumbers = pagesLength
        .where((text) => RegExp(r'^\d+$').hasMatch(text))
        .map(int.parse)
        .toList();

    final List<WebscrapEntity> entityList = [];
    for (int i = 0; i < messages.length; i++) {
      entityList.add(WebscrapEntity(
        pagesLength: pageNumbers.last ?? 0,
        url: '',
        content: messages[i],
      ));
    }

    notifyListeners();
    return entityList;
  }
}
