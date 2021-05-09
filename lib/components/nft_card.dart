import 'package:flutter/material.dart';
import 'package:kastutorial/screens/send_nft_screen.dart';

class NftCard extends StatelessWidget {
  final String url;

  const NftCard({
    Key key,
    @required this.url,
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
              const ListTile(
                // leading: Icon(Icons.album),
                title: Text(
                  'Luffy',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  '캐릭터 카드',
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
