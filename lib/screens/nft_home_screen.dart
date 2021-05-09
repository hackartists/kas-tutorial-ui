import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kastutorial/components/nft_card.dart';
import 'package:kastutorial/screens/home_screen.dart';
import 'package:kastutorial/screens/issue_nft_screen.dart';

class NftHomeScreen extends StatefulWidget {
  @override
  NftHomeScreenState createState() => NftHomeScreenState();
}

class NftHomeScreenState extends State<NftHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 자산 목록'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              NftCard(
                  url:
                      "https://i.pinimg.com/originals/6f/66/30/6f66309d4fb6946f515ab8a2c55733c5.png"),
              Spacer(),
              NftCard(
                  url:
                      "https://lh3.googleusercontent.com/proxy/oMJi6J57XHa8kfMoaFz47VK_g493N2X2gW40SAU_x4Ht2SOfC1soTPaBw6BE31hSjTT_E5wGYdrKWIo7c0UxbrcoC8aOTFhm1ky5RiK9--EyQ-Tzm_lDcTrZ79NK0KUhPui5eirDOLFWUovaB_tmqdI-UOthwy6i1G1ycateo-yENbxh7nnAOZ8"),
              Spacer(),
              NftCard(
                url:
                    "https://i.pinimg.com/originals/6f/66/30/6f66309d4fb6946f515ab8a2c55733c5.png",
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '토큰 발행',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return IssueNftScreen();
              },
            ),
          );
        },
        child: Icon(Icons.create),
      ),
    );
  }
}
