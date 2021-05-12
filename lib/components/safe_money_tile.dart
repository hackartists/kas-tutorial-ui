import 'package:flutter/material.dart';

class SafeMoneyTile extends StatelessWidget {
  final String name;
  final String image;
  final String creator;

  const SafeMoneyTile({
    Key key, this.name, this.image, this.creator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 70,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: 70,
              height: 70,
              child: Image.network(image),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name),
                  Text(creator, style: TextStyle(color: Colors.grey))
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
    );
  }
}
