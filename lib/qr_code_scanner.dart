import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'zypher.dart';
import 'your_orders.dart';
import 'package:url_launcher/url_launcher.dart';
import 'confirm_order.dart';


class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String qr_code = "";

  _launchURL() async {
    if(await canLaunch(qr_code)){
      await launch(qr_code);
    }else {
      throw 'Could not find the url';
    }
  }

  Future qrscan() async {
    try {
      String qr_code = await BarcodeScanner.scan();
      setState(() => this.qr_code = qr_code);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qr_code = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qr_code = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() =>
      this.qr_code =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qr_code = 'Unknown error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text("Drawer Header")),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset(
                  "qr_code.png",
                  width: 30,
                  height: 30,
                ),
                title: Text("Scan QR Code"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Scan()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset(
                  "your_order.png",
                  width: 30,
                  height: 30,
                ),
                title: Text("Your Orders"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Orders()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset(
                  "tick.png",
                  width: 30,
                  height: 30,
                ),
                title: Text("Confirm Your Order"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfirmOrder()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Zypher()),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Scan QR Code"),
        centerTitle: true,
      ),

        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: qrscan,
                    child: const Text('START CAMERA SCAN')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GestureDetector(
                    onTap: _launchURL,
                    child: Text(qr_code, textAlign: TextAlign.center,)),
              )
              ,
            ],
          ),
        ),
    );
  }
}






