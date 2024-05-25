import 'package:feliz_aniversario/controller/image_controller.dart';
import 'package:feliz_aniversario/entities/webscrap_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ImageSharedPage extends StatefulWidget {
  final String image;
  final ImageController ct;
  final WebscrapEntity entity;

  const ImageSharedPage(
      {super.key, required this.image, required this.ct, required this.entity});

  @override
  State<ImageSharedPage> createState() => _ImageSharedPageState();
}

class _ImageSharedPageState extends State<ImageSharedPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: widget.ct.fetchDescription(widget.entity.url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else {
          final content = snapshot.data;
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    Center(
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.image,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (content != null)
                              GestureDetector(
                                onLongPress: () {
                                  Clipboard.setData(
                                      ClipboardData(text: content));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Mensagem copiado para a área de transferência',
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    content,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => widget.ct.shareImageLink(widget.image),
                      icon: const Icon(Icons.share_rounded, size: 24),
                      label: const Text('Compartilhar'),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: content!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Mensagem copiada para a área de transferência'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 24),
                      label: const Text('Copiar Texto'),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
