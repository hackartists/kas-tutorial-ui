import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kastutorial/services/client.dart';

class IssueNftScreen extends StatefulWidget {
  final String username;

  const IssueNftScreen({
    Key key,
    this.username,
  }) : super(key: key);

  @override
  _IssueNftScreenState createState() => _IssueNftScreenState(this.username);
}

class _IssueNftScreenState extends State<IssueNftScreen> {
  String imagePath;
  String name;
  String kind = '캐릭터 카드';
  String username;

  _IssueNftScreenState(String username) {
    this.username = username;
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('토큰 발행'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 100,
            height: 200,
            child: InkWell(
              onTap: getImage,
              child: this.imagePath == null
                  ? Image.asset('assets/images/select-image.png')
                  : Image.file(File(this.imagePath)),
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                this.name = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '카드 이름',
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          DropdownButton<String>(
            isExpanded: true,
            value: kind,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                kind = newValue;
              });
            },
            items: <String>['캐릭터 카드', '아이템']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Spacer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '발행하기',
        onPressed: () async {
          String url = await Client.uploadImage(imagePath, name, kind);

          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
