import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class GoFeedDetail extends StatefulWidget {
  const GoFeedDetail({super.key, required this.feedid});

  final String feedid;
  @override
  State<GoFeedDetail> createState() => _GoFeedDetailState();
}

class _GoFeedDetailState extends State<GoFeedDetail> {
  List? infoFeedList;

  @override
  void initState() {

    _getInfoFeedList();
    // print(box.read('user_kod_masjid'));
    super.initState();
  }

  Future<String?> _getInfoFeedList() async {

    String stateInfoUrl = 'https://api.gomasjid.my/api/utama?cara=getInfoFeedDetail&feed_id=${widget.feedid}';
    // print(stateInfoUrl);
    await http.get(Uri.parse(stateInfoUrl), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        infoFeedList = data['infofeed'];
      });
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go feed')),
      body: SingleChildScrollView(
          child: Column(
            children: [
              for(var item in infoFeedList!)
              Hero(
              tag: "${item['slug']}",
              child: Image(
                  image: MemoryImage(base64Decode('${item['gambar_utama']}')),
                  fit: BoxFit.cover,
                  width: Get.width)),
          const SizedBox(height: 10),
              for(var item in infoFeedList!)
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage:
                        MemoryImage(base64Decode('${item['gambar_author']}')),
                    ),
                    title: Text(
                        "${item['first_name_author']} ${item['last_name_author']}",
                        style: const TextStyle(
                          // color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                      subtitle: Text("${item['date_added']}",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                          ))),
                  const SizedBox(height: 10),
                  Text("${item['tajuk']}",
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Text("${item['isi_kandungan']}"),
                ],
              ))
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
                child: Image.asset(image, fit: BoxFit.cover),
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
                            backgroundImage: AssetImage(authorImg)),
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
