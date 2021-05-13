import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kastutorial/components/nft_card.dart';
import 'package:kastutorial/components/toast.dart';
import 'package:kastutorial/services/client.dart';

class SignCardScreen extends StatefulWidget {
  final String tokenId;
  final String imageUrl;
  final String name;
  final String kind;
  final String username;
  final String transactionId;
  final String toUser;
  final String safeAddress;

  const SignCardScreen({
    Key key,
    this.tokenId,
    this.imageUrl,
    this.name,
    this.kind,
    this.username,
    this.transactionId,
    this.toUser,
    this.safeAddress,
  }) : super(key: key);

  @override
  _SignCardScreenState createState() => _SignCardScreenState();
}

class _SignCardScreenState extends State<SignCardScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('전송 승인'),
      ),
      body: Column(
        children: [
          NftCard(
            url: widget.imageUrl,
            name: widget.name,
            kind: widget.kind,
          ),
          TextField(
            controller: _controller,
            enableInteractiveSelection: false,
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.toUser,
            ),
          ),
          Spacer(),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                // Respond to button press
                try {
                  await Client.approveTransaction(
                    widget.username,
                    widget.transactionId,
                    widget.safeAddress,
                    widget.tokenId,
                  );
                  Toast.showToast(
                    context,
                    '카드 전송요청이 완료되었습니다.',
                    Colors.greenAccent,
                  );
                } catch (e) {
                  Toast.showToast(
                    context,
                    '카드 전송요청이 실패하였습니다.',
                    Colors.redAccent,
                  );
                } finally {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.send, size: 18),
              label: Text("서명하기"),
            ),
          ),
        ],
      ),
    );
  }
}
