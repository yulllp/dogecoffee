import 'package:doge_coffee/home.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        title: 'Payment success',
        desc: 'Pembayaran berhasil dilakukan!',
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        },
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
