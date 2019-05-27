import 'package:flutter/material.dart';
import 'zypher.dart';
import 'qr_code_scanner.dart';
import 'your_orders.dart';

class ConfirmOrder extends StatelessWidget {
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
        title: Text("Confirm Order"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Confirm Your Order",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Become a subscribed user to take these \n books for free",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Box ID: ZB-12341"),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("#Business Collections"),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 500,
                      height: 220,
                      child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int pos) {
                            return Column(
                              children: <Widget>[
                                Image.asset(
                                  "book.jpeg",
                                  width: 120,
                                  height: 170,
                                ),
                                Text(
                                  "Prod Name",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  "Author",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
                      child: Center(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Orders()),
                            );
                          },
                          color: Colors.green,
                          splashColor: Colors.lightGreen,
                          child: Text(
                            "Activate Plan @ 999 / 3 Months",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Whats Included in Plan?")),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
