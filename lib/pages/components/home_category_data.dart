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
        'https://images.pexels.com/photos/4114731/pexels-photo-4114731.jpeg?auto=compress&cs=tinysrgb&w=400',
  ),
  geral(
    name: "Geral",
    path: "aniversario",
    image:
        'https://images.pexels.com/photos/3534022/pexels-photo-3534022.jpeg?auto=compress&cs=tinysrgb&w=400',
  ),
  pai(
      name: "Pai",
      path: "melhores_mensagens_de_feliz_aniversario_para_pai",
      image:
          "https://images.pexels.com/photos/4815119/pexels-photo-4815119.jpeg?auto=compress&cs=tinysrgb&w=400"),
  irmao(
      name: "Irmão",
      path: "aniversario_irmao",
      image:
          "https://images.pexels.com/photos/5804893/pexels-photo-5804893.jpeg?auto=compress&cs=tinysrgb&w=400"),
  irma(
      name: "Irmã",
      path: "aniversario_irma",
      image:
          "https://images.pexels.com/photos/10033224/pexels-photo-10033224.jpeg?auto=compress&cs=tinysrgb&w=400"),
  avos(
      name: "Avós",
      path: "aniversario_avo",
      image:
          "https://images.pexels.com/photos/5729077/pexels-photo-5729077.jpeg?auto=compress&cs=tinysrgb&w=400"),
  // tio(
  //     name: "Tio",
  //     path: "mensagens_de_aniversario_para_tio",
  //     image: "https://www.pensador.com/mensagens_de_aniversario_para_tio/"),
  tia(
      name: "Tia",
      path: "aniversario_tia",
      image:
          "https://images.pexels.com/photos/7867916/pexels-photo-7867916.jpeg?auto=compress&cs=tinysrgb&w=400"),
  primo(
      name: "Primo",
      path: "aniversario_primo",
      image:
          "https://images.pexels.com/photos/7099947/pexels-photo-7099947.jpeg?auto=compress&cs=tinysrgb&w=400"),
  prima(
      name: "Prima",
      path: "aniversario_prima",
      image:
          "https://images.pexels.com/photos/7099909/pexels-photo-7099909.jpeg?auto=compress&cs=tinysrgb&w=400"),
  chefe(
      name: "Chefe",
      path: "parabens_para_o_chefe",
      image:
          "https://images.pexels.com/photos/7180617/pexels-photo-7180617.jpeg?auto=compress&cs=tinysrgb&w=400"),
  colega(
      name: "Colega",
      path: "aniversario_colega",
      image:
          "https://images.pexels.com/photos/4262423/pexels-photo-4262423.jpeg?auto=compress&cs=tinysrgb&w=400"),
  namorado(
      name: "Namorado",
      path: "frases_de_aniversario_para_namorado",
      image:
          "https://images.pexels.com/photos/6800133/pexels-photo-6800133.jpeg?auto=compress&cs=tinysrgb&w=400"),
  namorada(
      name: "Namorada",
      path: "aniversario_namorada",
      image:
          "https://images.pexels.com/photos/3419692/pexels-photo-3419692.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
  marido(
      name: "Marido",
      path: "aniversario_marido",
      image:
          "https://images.pexels.com/photos/6667011/pexels-photo-6667011.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
  esposa(
      name: "Esposa",
      path: "aniversario_esposa",
      image:
          "https://images.pexels.com/photos/935789/pexels-photo-935789.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1");

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
