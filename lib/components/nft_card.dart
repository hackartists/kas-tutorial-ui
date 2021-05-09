import 'package:flutter/material.dart';
import 'package:kastutorial/screens/send_nft_screen.dart';

class NftCard extends StatelessWidget {
  final String url;
  final String name;
  final String kind;

  const NftCard({
    Key key,
    @required this.url,
    @required this.name,
    @required this.kind,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SendNftCardScreen();
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
