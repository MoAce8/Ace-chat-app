import 'package:ace_chat_app/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          child: QrImageView(
            data: UserCubit.get(context).user.email,
            version: 1,
            size: 240,
          ),
        ),
      ),
    );
  }
}
