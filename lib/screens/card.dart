import 'package:dvm2/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserCard extends StatefulWidget {
  String name, email, street, suite, city, zipcode, long, lat;
  bool isFriend = false;
  UserCard(
      {super.key,
      this.isFriend = false,
      required this.name,
      required this.email,
      required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.long,
      required this.lat});

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
            gradient: RadialGradient(
              center: Alignment(0.902, 1.1554),
              radius: 1.3374,
              colors: [
                Color.fromRGBO(255, 208, 0, 0.22),
                Color.fromRGBO(54, 54, 54, 0),
              ],
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          // nested Containers to implement 2 radial gradients
          child: Container(
            decoration: BoxDecoration(
              // way to implement inner shadows
              boxShadow: [
                const BoxShadow(
                  color: Color.fromRGBO(255, 203, 102, 0.15),
                ),
                const BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: -10.0,
                  blurRadius: 5.0,
                ),
              ],
              gradient: RadialGradient(
                center: Alignment(0.898, 0.026),
                radius: 1.6,
                colors: [
                  Color.fromRGBO(255, 168, 0, 0.13),
                  Color.fromRGBO(231, 153, 0, 0.1),
                  Color.fromRGBO(158, 105, 0, 0),
                ],
                stops: [0.0, 0.6414, 1.0],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(21, 26, 37, 21),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.name}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: (widget.isFriend) ? Colors.amber : Colors.white),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "${widget.email}",
                style: TextStyle(color: Colors.amberAccent, fontSize: 14),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "${widget.street} - ${widget.suite}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "${widget.city} - ${widget.zipcode}",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 19,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.long}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${widget.lat}",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ]),
      )
    ]);
  }
}
