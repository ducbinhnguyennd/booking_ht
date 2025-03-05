import 'package:flutter/material.dart';

class SearchSetDateScreen extends StatefulWidget {
  const SearchSetDateScreen({super.key});

  @override
  State<SearchSetDateScreen> createState() => _SearchSetDateScreenState();
}

class _SearchSetDateScreenState extends State<SearchSetDateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Chọn ngày',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000))),
              ],
            )),
        body: Container());
  }
}
