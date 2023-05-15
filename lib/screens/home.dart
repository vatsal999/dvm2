import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
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
  List<int> dbIfFriendList = [];
  String searchString = "";
  final searchController = TextEditingController();
  double _value = 0;
  bool is_range_filter = false;

  @override
  void initState() {
    super.initState();
    futureUserData = fetchUser();
  }

  Future<List<User>> fetchUser() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);
    List<User> myResList = [];
    List<int> temp = [];
    temp = await getFriendUsersIds();
    // print(temp);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      myResList =
          await jsonResponse.map((data) => User.fromJson(data)).toList();

      for (int i = 0; i < myResList.length; i++) {
        if (temp.contains(myResList[i].id)) {
          myResList[i].isFriend = true;
        } else {
          myResList[i].isFriend = false;
        }
      }
      return myResList;
    } else {
      throw Exception('Failed to load userdata');
    }
  }

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
                      onChanged: (value) {
                        setState(() {
                          searchString = value;
                        });
                      },
                      controller: searchController,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                          // constraints: BoxConstraints(maxHeight: 40),
                          filled: true,
                          hintText: "Search for name...",
                          hintStyle:
                              TextStyle(color: Color(0xFFC0C0C0), fontSize: 16),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xFFC0C0C0),
                          suffixIcon: Icon(Icons.close),
                          suffixIconColor: Color(0xFFC0C0C0),
                          fillColor: Color.fromARGB(255, 49, 44, 5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none))),
                  SizedBox(
                    height: 40,
                  ),
                  Slider(
                    min: -200.0,
                    max: 200.0,
                    value: _value,
                    activeColor: Colors.amber,
                    inactiveColor: Colors.grey,
                    thumbColor: amberAccent,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(gradDark),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(amberAccent),
                        ),
                        child: Text(!is_range_filter
                            ? 'Enable Filter'
                            : 'Disable Filter'),
                        onPressed: () {
                          setState(() {
                            is_range_filter = !is_range_filter;
                          });
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<User>>(
                    future: futureUserData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          // TODO: fix extra spaces when filtering list
                          child: ListView.separated(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 16),
                              itemBuilder: (BuildContext context, int index) {
                                // TODO: unfuck this mess
                                return (snapshot.data![index].name
                                            .toLowerCase()
                                            .contains(
                                                searchString.toLowerCase()) &&
                                        (is_range_filter
                                            ? (double.parse(snapshot
                                                        .data![index].lng) <
                                                    _value + 10 &&
                                                double.parse(snapshot
                                                        .data![index].lng) >
                                                    _value - 10)
                                            : true))
                                    ? GestureDetector(
                                        onTap: () {
                                          if (!snapshot.data![index].isFriend) {
                                            createUser(
                                                user: snapshot.data![index]);
                                          } else {
                                            deleteUser(
                                                user: snapshot.data![index]);
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
                                          zipcode:
                                              snapshot.data![index].zipcode,
                                          lng: snapshot.data![index].lng,
                                          lat: snapshot.data![index].lat,
                                          isFriend:
                                              snapshot.data![index].isFriend,
                                        ))
                                    : Container(
                                        height: 0,
                                      );
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
        ],
      ),
    );
  }
}
