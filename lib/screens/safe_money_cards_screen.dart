import 'package:flutter/material.dart';
import 'package:kastutorial/components/list_cards.dart';
import 'package:kastutorial/screens/send_nft_screen.dart';
import 'package:kastutorial/screens/sign_card_screen.dart';

class SafeMoneyCardsScreen extends StatelessWidget {
  final String address;
  final String username;
  final dynamic pendings;

  const SafeMoneyCardsScreen(
      {Key key, this.address, this.pendings, this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(pendings);
    return Scaffold(
      appBar: AppBar(
        title: Text('금고 카드'),
      ),
      body: Container(
        child: ListCards(
          pendings: pendings,
          username: this.address,
          onTab: (tokenId, url, name, kind) async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  if (pendings == null || pendings[tokenId] == null) {
                    return SendNftCardScreen(
                      tokenId: tokenId,
                      imageUrl: url,
                      name: name,
                      kind: kind,
                      username: username,
                      safeAddress: address,
                    );
                  } else {
                    return SignCardScreen(
                      tokenId: tokenId,
                      transactionId: pendings[tokenId]['txid'],
                      name: name,
                      imageUrl: url,
                      username: username,
                      kind: kind,
                      toUser: pendings[tokenId]['to'],
                      safeAddress: address,
                    );
                  }
                },
              ),
            );

            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
