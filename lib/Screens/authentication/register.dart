import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/model/auth_model.dart';
import 'package:store/view_model/auth_viewmodel.dart';

import '../../widgets/customtextfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Center(
                  child: Text(
                    'Let’s Create Account Together',
                    style: TextStyle(color: Color(0xFF707B81)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Customtextfield(
                  contoller: _namecontroller,
                  hint: 'Name',
                  hidetext: false,
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'User Name',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Customtextfield(
                  hint: 'Enter user name',
                  hidetext: false,
                  contoller: _usernamecontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email Address',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  hint: 'Enter email',
                  hidetext: false,
                  contoller: _emailcontroller,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Phone',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Customtextfield(
                  hint: 'Enter Phone',
                  hidetext: false,
                  contoller: _phonecontroller,
                ),
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  hint: 'enter password',
                  hidetext: true,
                  contoller: _passcontroller,
                  suffix: IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.eye_slash)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<AuthViewmodel>(
                  builder: (context, value, child) => value.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: 50,
                            width: 400,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5B9EE1)),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  value.reg(
                                      user: AuthenticationModel(
                                          name: _namecontroller.text,
                                          username: _usernamecontroller.text,
                                          email: _emailcontroller.text,
                                          phone: _phonecontroller.text,
                                          password: _passcontroller.text),
                                      context: context);
                                }
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlutterLogo(),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Sign in with google',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
