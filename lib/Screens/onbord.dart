import 'package:flutter/material.dart';
import 'package:store/Screens/authentication/login.dart';

import '../widgets/onbord13.dart';

class Onbord extends StatefulWidget {
  const Onbord({super.key});

  @override
  State<Onbord> createState() => _Onbord1State();
}

class _Onbord1State extends State<Onbord> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<String> btnname = ['Next', 'Next', 'Get Started'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                Onbord13(
                  image: 'assets/images/jacket.png',
                  title: 'Start Journey \nWith Jackets',
                  sub: 'Smart, Gorgeous & Fashionable \nCollection',
                ),
                Onbord13(
                  title: 'Follow Latest \nStyle Shoes',
                  image: 'assets/images/shoe.png',
                  sub:
                      'There Are Many Beautiful And \nAttractive Plants To Your Room',
                  roundimage: Image.asset('assets/images/shoe.png'),
                ),
                Onbord13(
                  image: 'assets/images/jacket shoe.png',
                  title: 'Summer Jackets \nNike 2022',
                  sub: 'Amet Minim Lit Nodeseru Saku \nNandu sit Alique Dolor',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      width: _currentPage == index ? 45.0 : 12.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == 3 - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signin(),
                            ));
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      btnname[_currentPage],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
