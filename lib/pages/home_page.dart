import 'package:cached_network_image/cached_network_image.dart';
import 'package:feliz_aniversario/controller/home_controller.dart';
import 'package:feliz_aniversario/pages/mensage_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool alphabeticalOrder = true;
  late HomeController ct;

  @override
  void initState() {
    super.initState();
    ct = HomeController(alphabeticalOrder);
  }

  void toggleSortOrder() {
    setState(() {
      alphabeticalOrder = !alphabeticalOrder;
      ct = HomeController(alphabeticalOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(166, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Categorias',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: toggleSortOrder,
            icon: Icon(
              alphabeticalOrder ? Icons.sort : Icons.filter_list,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.deepPurple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView.builder(
            itemCount: ct.category.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shrinkWrap: false,
            itemBuilder: (context, idx) {
              final category = ct.category[idx];
              return Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MensagePage.route,
                        arguments: category,
                      );
                    },
                    child: Card(
                      color: Colors.deepPurple[800],
                      elevation: 8,
                      shadowColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 4.0),
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  category.image,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
