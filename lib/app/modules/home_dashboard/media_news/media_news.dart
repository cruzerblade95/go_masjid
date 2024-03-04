import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import 'media_news_detail.dart';
import 'package:http/http.dart' as http;


class MediaNewsPage extends StatefulWidget {
  const MediaNewsPage({super.key});

  @override
  State<MediaNewsPage> createState() => _MediaNewsState();
}

class _MediaNewsState extends State<MediaNewsPage> {

  final box = GetStorage();

  List? mediaNewsList;

  @override
  void initState() {

    _getMediaNewsList();
    // print(box.read('user_kod_masjid'));
    super.initState();
  }

  Future<String?> _getMediaNewsList() async {

    String stateInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getMediaNews';
    // print(stateInfoUrl);
    await http.get(Uri.parse(stateInfoUrl), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        mediaNewsList = data['medianews'];
      });
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media & News')),
      body: SingleChildScrollView(
          child: Column(
            children: [
              for(var item in mediaNewsList!)
              BlogCard(
                  image: '${item['gambar_utama']}',
                  title: "${item['tajuk']}",
                  slug: "${item['slug']}",
                  desc: "${item['isi_kandungan']}",
                  author:
                  "${item['first_name_author']} ${item['last_name_author']}",
                  authorImg: '${item['gambar_author']}',
                  press: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MediaNewsDetail(feedid: '${item['id']}')));
                  }
              ),
              // BlogCard(
              //     image: 'assets/images/Everyonce.jpg',
              //     title: "Second Media Post",
              //     slug: "test2",
              //     desc: "Our second media post",
              //     author:
              //     "GoMasjid",
              //     authorImg: 'assets/icons/Home.png',
              //     press: (){
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => const MediaNewsDetail()));
              //     }
              // ),
            ],
          )),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard(
      {super.key,
        required this.image,
        required this.title,
        required this.desc,
        required this.author,
        required this.authorImg,
        required this.slug,
        required this.press});

  final String image, title, desc, author, authorImg, slug;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Card(
          elevation: 5,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(bottom: 20),
          surfaceTintColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: slug,
                child: Image.memory(base64Decode(image),
                    gaplessPlayback: true,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(desc,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.blueGrey)),
                    const SizedBox(height: 10),
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: MemoryImage(base64Decode(authorImg))),
                        title: Text(author,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ))),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
