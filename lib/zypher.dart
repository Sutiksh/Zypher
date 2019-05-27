import 'package:flutter/material.dart';
import 'dart:async'; //for async operation of the app
import 'dart:convert'; //to encode json file
import 'package:http/http.dart' as http;
import 'qr_code_scanner.dart';
import 'your_orders.dart';
import 'confirm_order.dart';

class Zypher extends StatefulWidget {
  @override
  _ZypherState createState() => _ZypherState();
}

class _ZypherState extends State<Zypher> {
  Map data;
  List authorsData = [];

  Future<Map> fetchAuthor() async {
    String getUrl = 'https://test-zypher.herokuapp.com/author/getAllAuthor';
    http.Response response = await http.get(getUrl);
    //debugPrint(response.body);
    data = json.decode(response.body);
    setState(() {
      authorsData = data["authors"];
    });
//    debugPrint(authorsData.toString());
  }

  @override
  void initState() {
    super.initState();
    fetchAuthor();
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
      appBar: new AppBar(
        //Appbar
    //    leading: IconButton(icon: Icon(Icons.menu)),
        iconTheme: new IconThemeData(color: Colors.black38),
        backgroundColor: Colors.white,
        elevation: 1.0,
        //action for menu
        title: new Text('#Zypher',
            style: TextStyle(
                fontSize: 17.2,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          //action for search
          IconButton(onPressed: null, icon: Icon(Icons.notifications)),
          //action for notifications
          IconButton(onPressed: null, icon: Icon(Icons.bookmark)),
          //action for bookmark
          IconButton(onPressed: null, icon: Icon(Icons.shopping_basket)),
          //action for basket
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 10, 8.0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Authors",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(3, 10, 0, 0),
              width: 350,
              height: 140,
              child: Card(
                color: Color.fromRGBO(238, 238, 238, 1),
                child: ListView.builder(
                    itemCount: authorsData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return new AboutAuthor(
                                index: index,
                                authId: ("${authorsData[index]["_id"]}"),
                              );
                            }),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 30.0,
                            child: ClipOval(
                              child: Image.network(
                                authorsData[index]["authorImage"],
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutAuthor extends StatefulWidget {
  int index;
  String authId;

  AboutAuthor({this.index, this.authId});

  @override
  _AboutAuthorState createState() => _AboutAuthorState();
}

class _AboutAuthorState extends State<AboutAuthor> {
  Map data;
  List authorsBooks = [];

  Future<Map> fetchAuthorDetails() async {
    String postUrl = 'https://test-zypher.herokuapp.com/author/viewDetails';
    http.Response response =
        await http.post(postUrl, body: {"authorId": widget.authId});
    data = json.decode(response.body);
    //debugPrint(data.toString());
    setState(() {
      authorsBooks = data["author"]["books"];
    });
//    debugPrint(authorsBooks.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAuthorDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //Appbar
        leading: new IconButton(icon: Icon(Icons.menu), onPressed: null),
        backgroundColor: Colors.white,
        elevation: 1.0,
        //action for menu
        title: new Text('#Zypher',
            style: TextStyle(
                fontSize: 17.2,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          //action for search
          IconButton(onPressed: null, icon: Icon(Icons.notifications)),
          //action for notifications
          IconButton(onPressed: null, icon: Icon(Icons.bookmark)),
          //action for bookmark
          IconButton(onPressed: null, icon: Icon(Icons.shopping_basket)),
          //action for basket
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: authorsBooks.length,
            itemBuilder: (BuildContext context, int pos) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Card(
                  margin: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(authorsBooks[pos]["imageURL"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${authorsBooks[pos]["productName"]}"
                            "\n"
                            "${authorsBooks[pos]["authorName"]}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
