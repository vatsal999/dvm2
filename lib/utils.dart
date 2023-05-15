import 'package:flutter/material.dart';

const Color amberAccent = Color.fromRGBO(248, 216, 72, 1);
const Color gradDark = Color.fromRGBO(164, 108, 0, 0.15);
const Color gradDarker = Color.fromRGBO(209, 154, 8, 0.15);

const RadialGradient cardGrad1 = RadialGradient(
  center: Alignment(0.902, 1.1554),
  radius: 1.3374,
  colors: [
    Color.fromRGBO(255, 208, 0, 0.22),
    Color.fromRGBO(54, 54, 54, 0),
  ],
  stops: [0.0, 1.0],
);

const RadialGradient cardGrad2 = RadialGradient(
  center: Alignment(0.898, 0.026),
  radius: 1.6,
  colors: [
    Color.fromRGBO(255, 168, 0, 0.13),
    Color.fromRGBO(231, 153, 0, 0.1),
    Color.fromRGBO(158, 105, 0, 0),
  ],
  stops: [0.0, 0.6414, 1.0],
);
