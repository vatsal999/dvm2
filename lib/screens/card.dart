import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserCard extends StatefulWidget {
  UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 192,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 168, 0, 0.13),
              Color.fromRGBO(231, 153, 0, 0.1),
              Color.fromRGBO(158, 105, 0, 0),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(21, 26, 37, 21),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "email",
                style: TextStyle(color: Colors.amberAccent, fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "street - suite",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "city - zipcode",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 19,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "long",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "lat",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ]),
      )
    ]);
  }
}
