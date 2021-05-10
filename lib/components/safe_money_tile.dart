import 'package:flutter/material.dart';

class SafeMoneyTile extends StatelessWidget {
  const SafeMoneyTile({
    Key key,
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
              child: Image.network(
                  "http://morimuri.co.kr/web/product/big/morimurij_672.jpg"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Test Title'),
                  Text('Test Video', style: TextStyle(color: Colors.grey))
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
