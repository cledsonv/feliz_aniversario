import 'package:feliz_aniversario/entities/category_entity.dart';

enum HomeCategory {
  mae(
    name: "Mãe",
    path: 'mensagem_de_feliz_aniversario_para_mae',
    image:
        'https://media.discordapp.net/attachments/1030715114158030868/1244010609755033600/mae-app.webp?ex=66538ea9&is=66523d29&hm=ad7fd087782ee45416138ee13e0f6c93916990eec9fc590a4871bc0ffc30dbe6&=&format=webp&width=420&height=420',
  ),
  amiga(
      name: "Amiga",
      path: 'mensagens_de_aniversario_emocionantes_para_amiga',
      image:
          'https://media.discordapp.net/attachments/1030715114158030868/1244023276984991754/amiga-app.webp?ex=66539a76&is=665248f6&hm=8768b8936f3ae9db7ce7c379a7ae876bedf930bbe5226658e1a3d17fa6e847cd&=&format=webp&width=420&height=420'),
  amigo(
    name: "Amigo",
    path: 'melhores_mensagens_de_aniversario_para_amigo',
    image:
        'https://media.discordapp.net/attachments/1030715114158030868/1244008148088520724/friends-app.webp?ex=66538c5f&is=66523adf&hm=05a1a779b5de8ae525399e9493fb69294d0c17c64567b09196394059647f2f8b&=&format=webp&width=420&height=420',
  ),
  geral(
    name: "Geral",
    path: "aniversario",
    image:
        'https://media.discordapp.net/attachments/1030715114158030868/1244008148088520724/friends-app.webp?ex=66538c5f&is=66523adf&hm=05a1a779b5de8ae525399e9493fb69294d0c17c64567b09196394059647f2f8b&=&format=webp&width=420&height=420',
  ),
  pai(
      name: "Pai",
      path: "melhores_mensagens_de_feliz_aniversario_para_pai",
      image: "https://www.pensador.com/mensagens_de_aniversario_para_pai/"),
  irmao(
      name: "Irmão",
      path: "mensagens_de_aniversario_para_irmao",
      image: "https://www.pensador.com/mensagens_de_aniversario_para_irmao/"),
  irma(
      name: "Irmã",
      path: "mensagens_de_aniversario_para_irma",
      image: "https://www.pensador.com/mensagens_de_aniversario_para_irma/"),
  avos(
      name: "Avós",
      path: "mensagens_de_aniversario_para_avos",
      image: "https://www.pensador.com/mensagens_de_aniversario_para_avos/"),
  tio(
      name: "Tio",
      path: "mensagens_de_aniversario_para_tio",
      image: "https://www.pensador.com/mensagens_de_aniversario_para_tio/"),
  tia(
      name: "Tia",
      path: "mensagens_de_aniversario_para_tia",
      image: "https://www.pensador.com/mensagens_de_aniversario_para_tia/"),
  primos(
      name: "Primos",
      path: "mensagens_de_aniversario_para_primos",
      image: "https://www.pensador.com/mensagens_de_aniversario_para_primos/");

  final String name;
  final String path;
  final String image;
  const HomeCategory(
      {required this.name, required this.path, required this.image});
}

List<CategoryEntity> getCategories() {
  return HomeCategory.values.map((category) {
    return CategoryEntity(
      name: category.name,
      image: category.image,
      path: category.path,
    );
  }).toList();
}
