import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dvm2/screens/card.dart';
import 'package:dvm2/user_model.dart';
import 'package:dvm2/dbhelper.dart';
import 'package:dvm2/utils.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late Future<List<User>> futureUserData;
  List<User> displaylist = [];

  @override
  void initState() {
    super.initState();
    futureUserData = fetchUser();
    print(displaylist);
  }

  Future<List<User>> fetchUser() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load userdata');
    }
  }

  void friend_toggle(int id) {
    print("hello");
  }

  final item = List<String>.generate(10, (i) => ' Item $i');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x001E1E1E),
      body: Stack(
        children: <Widget>[
          Image(image: AssetImage("assets/images/lines.png")),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 80, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Users",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                      decoration: InputDecoration(
                          // constraints: BoxConstraints(maxHeight: 40),
                          filled: true,
                          hintText: "Search for name...",
                          hintStyle:
                              TextStyle(color: Color(0xFFC0C0C0), fontSize: 16),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xFFC0C0C0),
                          fillColor: Color.fromARGB(255, 49, 44, 5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none))),
                  SizedBox(
                    height: 73,
                  ),
                  FutureBuilder<List<User>>(
                    future: futureUserData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.separated(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 16),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      if (!snapshot.data![index].isFriend) {
                                        createUser(user: snapshot.data![index]);
                                      } else {
                                        deleteUser(user: snapshot.data![index]);
                                      }
                                      setState(() {
                                        snapshot.data![index].isFriend =
                                            !snapshot.data![index].isFriend;
                                      });
                                    },
                                    child: UserCard(
                                      name: snapshot.data![index].name,
                                      email: snapshot.data![index].email,
                                      street: snapshot.data![index].street,
                                      suite: snapshot.data![index].suite,
                                      city: snapshot.data![index].city,
                                      zipcode: snapshot.data![index].zipcode,
                                      lng: snapshot.data![index].lng,
                                      lat: snapshot.data![index].lat,
                                      isFriend: snapshot.data![index].isFriend,
                                    ));
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const Center(
                          child: const CircularProgressIndicator(
                        color: amberAccent,
                      ));
                    },
                  ),
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
