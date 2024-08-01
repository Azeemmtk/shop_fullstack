import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/authentication/login.dart';
import 'package:store/view_model/auth_viewmodel.dart';
import 'package:store/view_model/cart_viewmodel.dart';
import 'package:store/view_model/home_view_model.dart';

void main() {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Signin(),
      ),
    ),
  );
}
