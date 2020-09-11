import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/services/CRUD.dart';
import 'package:shop_app/services/crudobj.dart';

import '../../../constants.dart';
import '../../../constants.dart';
import 'categorries.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  crudMedthods crudObj = new crudMedthods();
  CRUDMethods methods = new CRUDMethods();
  QuerySnapshot qs;

  QuerySnapshot postmethods;

  @override
  void initState() {
    crudObj.getHomeData().then((results) {
      setState(() {
        qs = results;
      });
    });

    methods.getData().then((results) {
      setState(() {
        postmethods = results;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 130, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/icons/internet.png",
                      height: 30,
                      width: 50,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "DELIVERY WORLDWIDE",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/icons/transfer.png",
                      height: 30,
                      width: 50,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "RETURN EXCHANGE",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/icons/phone.png",
                      height: 30,
                      width: 50,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "EXCELLENT SUPPORT",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: Text(
                      "kosher",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontFamily: "Pacifico"),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/search.svg",
                          // By default our  icon color is white
                          color: kTextColor,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/cart.svg",
                          // By default our  icon color is white
                          color: kTextColor,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
              Categories(),
              Expanded(
                child: Container(
                  //color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: postmethods.documents.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //mainAxisSpacing: kDefaultPaddin,
                          // crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, i) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              color: Colors.white,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext c) =>
                                              DetailsScreen(
                                                photo: postmethods.documents[i]
                                                    .data['photourl'],
                                                name: postmethods.documents[i].data['title'],
                                                price: postmethods.documents[i].data['price'],
                                                details: postmethods.documents[i].data['details'],
                                              )));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        //padding: EdgeInsets.all(kDefaultPaddin),
                                        // For  demo we use fixed height  and width
                                        // Now we dont need them
                                        // height: 180,
                                        // width: 160,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Hero(
                                          tag:
                                              "${postmethods.documents[i].data['photourl']}",
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: postmethods
                                                    .documents[i]
                                                    .data['photourl'],
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: kDefaultPaddin / 4),
                                      child: Text(
                                        // products is out demo list
                                        postmethods.documents[i].data['title'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      "GHs${postmethods.documents[i].data['number']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
