import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Image(image: AssetImage("assets/images/lines.png")),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Users",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 40),
                          filled: true,
                          hintText: "Search for name...",
                          hintStyle:
                              TextStyle(color: Color(0xFFC0C0C0), fontSize: 16),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xFFC0C0C0),
                          fillColor: Color.fromARGB(255, 97, 86, 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none))),
                ],
              )),
          // SvgPicture.asset(
          //   "assets/images/line_graphic.svg",
          //   alignment: Alignment.center,
          //   width: MediaQuery.of(context).size.width * 3,
          //   height: MediaQuery.of(context).size.height * 3,
          // ),
        ],
      ),
    );
  }
}
