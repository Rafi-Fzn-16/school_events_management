import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputNama = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "School Events ",
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: "Management",
                style: TextStyle(color: Color.fromARGB(255, 255, 84, 84)),
              ),
            ],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          TextField(
            controller: inputNama,
            onSubmitted: (values) {
              inputNama.text = values;
            },
          ),
          ElevatedButton(
            child: Text("Tampilkan Nama"),
            onPressed: () {
              print(inputNama.text);
            },
          ),
        ],
      ),
    );
  }
}
