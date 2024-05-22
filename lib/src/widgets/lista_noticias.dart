import 'package:flutter/material.dart';
import 'package:news_provider/src/models/news_models.dart';
import 'package:news_provider/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article>? noticias;

  const ListaNoticias({super.key, required this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.noticias?.length,
        itemBuilder: (BuildContext context, index) {
          return _Noticia(noticia: this.noticias![index], index: index);
        });
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TargetaTopBar(noticia: this.noticia, index: this.index),
        _TargetaTitulo(noticia: this.noticia),
        _TargetaImagen(noticia: this.noticia),
        _TarjetaBody(noticia: this.noticia),
        _TarjetaBotones(),
        SizedBox(height: 10),
        Divider()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description != null) ? noticia.description! : ''),
    );
  }
}

class _TargetaImagen extends StatelessWidget {
  final Article noticia;

  const _TargetaImagen({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: (noticia.urlToImage != null)
                ? Image(
                    //placeholder: const AssetImage('assets/no-image.png'),
                    image: NetworkImage(noticia.urlToImage!),
                  )
                : const Image(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDpYgKX6Na9EAfhKgjLD4iyPugeNE0wggdkw&s'))),
      ),
    );
  }
}

class _TargetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TargetaTitulo({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}

class _TargetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TargetaTopBar({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: Colors.red)),
          Text('${noticia.source.name}.'),
        ],
      ),
    );
  }
}
