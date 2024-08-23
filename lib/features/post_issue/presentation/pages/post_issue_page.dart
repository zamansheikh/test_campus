import 'package:flutter/material.dart';

class PostIssuePage extends StatelessWidget {
  const PostIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post an Issue")),
      body: const Center(child: Text("Post Issue Form")),
    );
  }
}
