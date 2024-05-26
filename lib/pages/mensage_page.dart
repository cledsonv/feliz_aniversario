import 'package:feliz_aniversario/controller/image_controller.dart';
import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MensagePage extends StatefulWidget {
  static const route = '/message';
  const MensagePage({super.key});

  @override
  State<MensagePage> createState() => _MensagePageState();
}

class _MensagePageState extends State<MensagePage> {
  final ImageController ct = ImageController();
  bool order = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ct.init(context);
    });

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
        title: Text(ct.getPageName(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 41, 23, 72),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_by_alpha, color: Colors.white),
            onPressed: () {
              order = !order;
              ct.sortItemsAlphabetically(order);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 41, 23, 72),
              Color.fromARGB(255, 0, 0, 0)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: PagedListView<int, WebscrapEntity>(
            pagingController: ct.pagingController,
            builderDelegate: PagedChildBuilderDelegate<WebscrapEntity>(
              itemBuilder: (context, entity, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entity.content,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 156, 111, 234),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: entity.content));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Texto copiado para a área de transferência'),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Copiar texto',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.copy,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
