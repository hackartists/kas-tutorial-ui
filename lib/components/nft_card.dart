import 'package:flutter/material.dart';
import 'package:kastutorial/screens/send_nft_screen.dart';

typedef void NftCardCallback(tokenId, url, name, kind);

class NftCard extends StatelessWidget {
  final String url;
  final String name;
  final String kind;
  final String tokenId;
  final String username;
  final double width;
  final double height;
  NftCardCallback onTab;

  NftCard({
    Key key,
    @required this.url,
    @required this.name,
    @required this.kind,
    this.tokenId,
    this.username,
    this.width,
    this.height,
    this.onTab,
  }) : super(key: key);

  GestureTapCallback onTabDefault(context) {
    return () {
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
    };
  }

  @override
  Widget build(BuildContext context) {
    double width = (this.width == null) ? 110 : this.width;
    double height = (this.height == null) ? 150 : this.height;

    return InkWell(
      onTap: (this.onTab == null)
          ? onTabDefault(context)
          : () {
              this.onTab(tokenId, url, name, kind);
            },
      child: Card(
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: width,
                height: height,
                child: ColoredBox(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                  child: (url != '')
                      ? Image.network(
                          url,
                          width: width,
                        )
                      : null,
                ),
              ),
              ListTile(
                // leading: Icon(Icons.album),
                title: Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
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
