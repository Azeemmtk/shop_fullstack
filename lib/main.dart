import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/splash_screen.dart';
import 'package:store/utils/contants.dart';
import 'package:store/view_model/auth_viewmodel.dart';
import 'package:store/view_model/cart_viewmodel.dart';
import 'package:store/view_model/favourite_viewmodel.dart';
import 'package:store/view_model/home_view_model.dart';

void main() {
  Gemini.init(apiKey: Gemini_key);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouriteViewmodel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    ),
  );
}
