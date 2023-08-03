import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:social_media_app/utils/constants/colors.dart';
import 'package:social_media_app/utils/constants/sizing.dart';

import '../../utils/constants/styling.dart';

class BarCodeScan extends StatefulWidget {
  const BarCodeScan({super.key});

  @override
  State<BarCodeScan> createState() => _BarCodeScanState();
}

class _BarCodeScanState extends State<BarCodeScan> {
  final resultController = TextEditingController();
  String barcode = 'Unknown';
  final currUser = FirebaseAuth.instance.currentUser!;
  // scan barcode
  Future<void> scarBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          '#ffCE461B', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.barcode = barcode;
      });
    } on PlatformException {
      barcode = 'failed to get platform version';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text('${currUser.email}  Scan your Product')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: scarBarcode, child: const Icon(Icons.barcode_reader)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Text(
                'Scan Result',
                style:
                    Styles.headLine.copyWith(fontSize: 20, color: Colors.black),
              ),
            ),
            AppSizing.h25,
            Center(
              child: Text(
                barcode,
                style: Styles.primaryTextStyle
                    .copyWith(color: AppColors.buttonColor, fontSize: 25),
              ),
            ),
            // CustomTextField(
            //   hintText: resultController.text,
            //   controller: resultController,
            // ),
          ],
        ),
      ),
    );
  }

  void postMessage() {}
}
