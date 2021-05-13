import 'package:flutter/material.dart';
import 'package:kastutorial/screens/safe_money_cards_screen.dart';

class SafeMoneyTile extends StatefulWidget {
  final String name;
  final String image;
  final String creator;
  final String tokenId;
  final String address;
  final String username;
  final dynamic pendings;

  const SafeMoneyTile({
    Key key,
    this.name,
    this.image,
    this.creator,
    this.tokenId,
    this.address,
    this.pendings,
    this.username,
  }) : super(key: key);

  @override
  _SafeMoneyTileState createState() => _SafeMoneyTileState();
}

class _SafeMoneyTileState extends State<SafeMoneyTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SafeMoneyCardsScreen(
                address: widget.address,
                pendings: widget.pendings,
                username: widget.username,
              );
            },
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 70,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                width: 70,
                height: 70,
                child: Image.network(widget.image),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.name),
                    Text(widget.creator, style: TextStyle(color: Colors.grey))
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
