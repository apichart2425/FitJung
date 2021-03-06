import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitjung/UI/SigninScreen.dart';
import 'package:fitjung/utility/firestore_util.dart';
import 'package:fitjung/utility/share.dart';
import 'package:flutter/material.dart';
import '../Icon/CustomIcon.dart';
import '../data.dart';
import 'dart:math';
import 'ModeScreen.dart';
import 'ProfileScreen.dart';
import 'ProfileUser.dart';
import 'article.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.25;

class HomeState extends State<HomeScreen> {
  var currentPage = images.length - 1.0;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController(text: "test");
  var url =
      'https://cdn3.iconfinder.com/data/icons/map-and-location-fill/144/People_Location-512.png';

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.loadLastLogin().then((value) {
      setState(() {
        email.text = value.toString();
        FirestoreUtils.getData(value).then((result) {
          setState(() {
            name.text = result.data['name'];
            name.text += " " + result.data['surname'];
            getUrlImage();
          });
        });
      });
    });
  }

  getUrlImage() async {
    final ref = FirebaseStorage.instance.ref().child(email.text);
    var url = await ref.getDownloadURL();
    setState(() {
      this.url = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screen_w = MediaQuery.of(context).size.width,
        screen_h = MediaQuery.of(context).size.height;
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("FitJung"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        drawer: new Drawer(
          child: Container(
            color: Color(0XFF282e46),
            child: new ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: new Text(name.text),
                  accountEmail: new Text(email.text),
                  currentAccountPicture: new CircleAvatar(
                    backgroundImage: NetworkImage(url),
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.deepPurple
                            : Colors.white,
                    child: new Text(name.text.substring(0, 1).toUpperCase()),
                  ),
                  otherAccountsPictures: <Widget>[
                    new IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                    )
                  ],
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileUser()),
                    );
                    // Navigator.pushReplacementNamed(context, '/profileuser');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Map',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/map');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    SharedPreferencesUtil.saveLastLogin(null);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SigninScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Course",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 46.0,
                              fontFamily: "Calibre-Semibold",
                              letterSpacing: 1.0,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Text("Exercise Library",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 18.0))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ModeScreen(currentPage.toInt())));
                    },
                    child: Stack(
                      children: <Widget>[
                        CardScrollWidget(currentPage),
                        Positioned.fill(
                          child: PageView.builder(
                            itemCount: images.length,
                            controller: controller,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return Container();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tips",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 46.0,
                              fontFamily: "Calibre-Semibold",
                              letterSpacing: 1.0,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Text("Clean health fitness education blog..",
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream:
                          Firestore.instance.collection('article').snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: new Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Image.network(
                                                    'https://sv1.picz.in.th/images/2019/05/27/wGXHA9.jpg',
                                                    width: screen_w * .4,
                                                    height: screen_h * .25,
                                                  ),
                                                  Text("Healthy Life"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Article(0)));
                                          },
                                        ),
                                        GestureDetector(
                                          child: new Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Image.network(
                                                    'https://sv1.picz.in.th/images/2019/05/27/wGX81D.jpg',
                                                    width: screen_w * .4,
                                                    height: screen_h * .25,
                                                  ),
                                                  Text("What's good workout?")
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Article(1)));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: new Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Image.network(
                                                    'https://sv1.picz.in.th/images/2019/05/27/wGXVLJ.jpg',
                                                    width: screen_w * .4,
                                                    height: screen_h * .25,
                                                  ),
                                                  Text("Healthy Food !!")
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Article(2)));
                                          },
                                        ),
                                        GestureDetector(
                                          child: new Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Image.network(
                                                    'https://sv1.picz.in.th/images/2019/05/27/wGXakb.png',
                                                    width: screen_w * .4,
                                                    height: screen_h * .25,
                                                  ),
                                                  Text("Treat Depression")
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Article(3)));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,)
                                ],
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(title[i],
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}