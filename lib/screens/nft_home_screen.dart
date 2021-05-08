import 'package:flutter/material.dart';

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
      body: Card(
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                "https://i.pinimg.com/originals/6f/66/30/6f66309d4fb6946f515ab8a2c55733c5.png",
                width: 100,
                height: 200,
              ),
              const ListTile(
                // leading: Icon(Icons.album),
                title: Text('The Enchanted '),
                subtitle: Text('Music by Julie Gabl'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),

      // Column(
      //   children: [
      //     Row(
      //       children: [
      //         Card(
      //           clipBehavior: Clip.antiAlias,
      //           elevation: 8,
      //           child: InkWell(
      //             onTap: () {},
      //             child: ListTile(
      //               leading: Icon(Icons.arrow_drop_down_circle),
      //               title: const Text('Card title 1'),
      //               subtitle: Text(
      //                 'Secondary Text',
      //                 style: TextStyle(color: Colors.black.withOpacity(0.6)),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        tooltip: '토큰 발행',
        onPressed: () {},
        child: Icon(Icons.create),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image.network(
        //   "https://i.pinimg.com/originals/6f/66/30/6f66309d4fb6946f515ab8a2c55733c5.png",
        //   width: 100,
        //   height: 200,
        // ),
        // Text('Luffy'),

        // ListTile(
        //   title: const Text('Luffy'),
        //   //   subtitle: Text(
        //   //     '캐릭터 카드',
        //   //     style: TextStyle(color: Colors.black.withOpacity(0.6)),
        //   //   ),
        // ),
      ],
    );
  }
}
