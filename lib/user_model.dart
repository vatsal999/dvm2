import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String name, email, street, suite, city, zipcode, lng, lat;
  bool isFriend;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.lng,
    required this.lat,
    this.isFriend = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      street: json['address']['street'],
      suite: json['address']['suite'],
      city: json['address']['city'],
      zipcode: json['address']['zipcode'],
      lng: json['address']['geo']['lng'],
      lat: json['address']['geo']['lat'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'lng': lng,
        'lat': lat
      };
}
