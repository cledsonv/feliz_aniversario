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
  HomeController ct = HomeController();

  @override
  void initState() {
    super.initState();
    ct.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(166, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ct.isSearching
            ? SizedBox(
                height: 40,
                child: TextField(
                  controller: ct.searchController,
                  onChanged: (value) {
                    setState(() {
                      ct.searchCategory(value);
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Pesquisar categoria...',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              )
            : const Text(
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
            onPressed: () => {
              setState(() {
                ct.isSearching = !ct.isSearching;
              })
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                ct.alphabeticalOrder = !ct.alphabeticalOrder;
                ct.organizeList();
              });
            },
            icon: Icon(
              ct.alphabeticalOrder ? Icons.sort : Icons.filter_list,
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
            itemCount: ct.resultCategory.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shrinkWrap: false,
            itemBuilder: (context, idx) {
              final category = ct.resultCategory[idx];
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
