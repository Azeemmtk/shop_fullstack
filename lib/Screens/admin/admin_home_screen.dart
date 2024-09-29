import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/admin/coplaint_screen.dart';
import 'package:store/Screens/admin/edit_screen.dart';
import 'package:store/view_model/home_view_model.dart';

import '../../utils/contants.dart';
import 'additem_screen.dart';
import 'order_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context, listen: false).fetchProducts(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    print(provider.products.length);

    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: DrawerHeader(
              decoration: BoxDecoration(color: maincolor),
              child: Text(
                'Menu',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminHomeScreen(),
                  ));
            },
            leading: Icon(
              Icons.home_filled,
              color: maincolor,
            ),
            title: Text('Home', style: TextStyle(color: maincolor)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Orders(),
                  ));
            },
            leading: Icon(
              FontAwesomeIcons.firstOrder,
              color: maincolor,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                color: maincolor,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Complaint(),
                  ));
            },
            leading: Icon(
              FontAwesomeIcons.comment,
              color: maincolor,
            ),
            title: Text(
              'Complaints',
              style: TextStyle(
                color: maincolor,
              ),
            ),
          ),
        ],
      )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Row(
          children: [
            Text(
              'All Products',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red[300],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: maincolor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdditemScreen(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (100 / 130),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: secondaycolor,
                    elevation: 7,
                    shadowColor: maincolor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  provider.products[index].category == 'jacket'
                                      ? FontAwesomeIcons.shirt
                                      : FontAwesomeIcons.shoePrints,
                                  color: maincolor,
                                  size: 15,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 130,
                              width: 130,
                              child: Hero(
                                tag: provider.products[index].image!,
                                child: Image.network(
                                  provider.products[index].image ?? 'name',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(provider.products[index].name ?? 'name'),
                            Text(
                              provider.products[index].colour ?? 'name',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              '₹ ${provider.products[index].price ?? 'name'}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
