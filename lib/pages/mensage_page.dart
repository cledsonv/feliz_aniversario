import 'package:feliz_aniversario/controller/image_controller.dart';
import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:feliz_aniversario/pages/image_shared_page.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MensagePage extends StatefulWidget {
  static const route = '/mensage';
  const MensagePage({super.key});

  @override
  State<MensagePage> createState() => _MensagePageState();
}

class _MensagePageState extends State<MensagePage> {
  final ImageController ct = ImageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ct.category!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            PagedSliverGrid<int, WebscrapEntity>(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              pagingController: ct.pagingController,
              builderDelegate: PagedChildBuilderDelegate<WebscrapEntity>(
                  itemBuilder: (context, entity, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageSharedPage(
                            image: entity.images,
                            ct: ct,
                            entity: entity,
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      entity.images,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
