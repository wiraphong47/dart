import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apitest/model/album.dart';
import 'dart:convert';

class ShowAlbum extends StatefulWidget {
  const ShowAlbum({super.key});

  @override
  State<ShowAlbum> createState() => _ShowAlbumState();
}

class _ShowAlbumState extends State<ShowAlbum> {
  Future<List<Album>> postFuture = getPosts();

  static Future<List<Album>> getPosts() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Album.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show album"),
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: postFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildPosts(List<Album> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(post.url!),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Text(post.title!),
              ),
            ],
          ),
        );
      },
    );
  }
}
