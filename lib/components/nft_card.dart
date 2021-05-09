import 'package:flutter/material.dart';
import 'package:kastutorial/screens/send_nft_screen.dart';

class NftCard extends StatelessWidget {
  final String url;
  final String name;
  final String kind;
  final String tokenId;
  final String username;

  const NftCard({
    Key key,
    @required this.url,
    @required this.name,
    @required this.kind,
    this.tokenId,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (tokenId == null) return;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SendNftCardScreen(
                tokenId: tokenId,
                imageUrl: url,
                name: name,
                kind: kind,
                username: username,
              );
            },
          ),
        );
      },
      child: Card(
        child: SizedBox(
          width: 110,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 150,
                child: ColoredBox(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                  child: Image.network(
                    url,
                    width: 150,
                  ),
                ),
              ),
              ListTile(
                // leading: Icon(Icons.album),
                title: Text(
                  name,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  kind,
                  style: TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
