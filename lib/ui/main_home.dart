import 'dart:convert';
import 'dart:developer';

import 'package:blog/ui/settings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';
import 'platforms/stripe_checkout.dart'

    if (dart.library.js) 'platforms/stripe_checkout_web.dart';

final kApiUrl = defaultTargetPlatform == TargetPlatform.android
    ? 'http://10.0.2.2:4242'
    : 'http://localhost:4242';

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Theme.of(context).cardColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        )),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildheader(context),
              buildItems(context),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Badge(
                badgeContent: Text(
                  '5',
                  style: TextStyle(color: Theme.of(context).buttonColor),
                ),
                position: BadgePosition.topEnd(),
                badgeColor: Theme.of(context).cardColor,
                child: Icon(
                  Icons.notifications,
                  color: Theme.of(context).buttonColor,
                ),
              )),
          const SizedBox(
            width: 30,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AboutPage())));
              },
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).buttonColor,
              )),
          const SizedBox(
            width: 20,
          ),
        ],
        leading: IconButton(
            onPressed: () {
              _displayDrawer(context);
            },
            icon: Icon(Icons.menu, color: Theme.of(context).buttonColor)),
        title: Text(
          'Alchemist blog',
          style: TextStyle(
            color: Theme.of(context).buttonColor,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          height: 90,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
                selectedIcon: Icon(Icons.home_filled)),
            NavigationDestination(
                icon: Icon(Icons.group_outlined),
                label: 'Community',
                selectedIcon: Icon(Icons.group)),
            NavigationDestination(
                icon: Icon(Icons.book_outlined),
                label: 'Resume',
                selectedIcon: Icon(Icons.book)),
            NavigationDestination(
                icon: Icon(Icons.now_widgets_outlined),
                label: 'Apps',
                selectedIcon: Icon(Icons.now_widgets_rounded)),
          ]),
    );
  }

  _displayDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }

  Widget buildheader(BuildContext context) {
    return Container(
      color: Colors.blue.shade200,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Text(
                'Ab',
                style: TextStyle(
                  color: Theme.of(context).buttonColor,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Alchemist blog'),
            SizedBox(
              height: 8,
            ),
            const Text('All Rights reserved @2022'),
          ],
        ),
      ),
    );
  }

  Widget buildItems(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          onTap: () {
            print('Alex loves hernesy');
          },
          leading: Icon(Icons.info_outline_rounded,
              color: Theme.of(context).buttonColor),
          title: Text(
            'info',
            style: TextStyle(color: Theme.of(context).buttonColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).buttonColor,
            size: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {
            print('Alex loves hernesy');
          },
          leading: Icon(
            Icons.handyman_outlined,
            color: Theme.of(context).buttonColor,
          ),
          title: Text(
            'Technology Previews',
            style: TextStyle(color: Theme.of(context).buttonColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).buttonColor,
            size: 14,
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Center(
          child: InkWell(
            onTap: () async {
             await getCheckout();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).buttonColor,
              ),
              height: 50,
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Center(
                child: Text('Buy coffee',
                    style: TextStyle(color: Theme.of(context).cardColor)),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> getCheckout() async {
    final String sessionId = await _createCheckoutSession();
    final result = await redirectToCheckout(
      context: context,
      sessionId: sessionId,
      publishableKey:
          'pk_test_51JmZ2YDQ62BPfBNGMeN9Te36MFjPddnlbjS96goXrNV5CuyxWyZBSzDcqh1Jm9kVTrX8RvJMj7nX5dgRk4DBk6V000LXTlfX6c',
      successUrl: 'https://checkout.stripe.dev/success',
      canceledUrl: 'https://checkout.stripe.dev/cancel',
    );

    if (mounted) {
      final text = result.when(
        success: () => 'Paid succesfully',
        canceled: () => 'Checkout canceled',
        error: (e) => 'Error $e',
        redirected: () => 'Redirected succesfully',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text)),
      );
    }
  }

  Future<String> _createCheckoutSession() async {
    final url = Uri.parse('$kApiUrl/create-checkout-session');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        if (kIsWeb) 'port': '',
      }),
    );
    final Map<String, dynamic> bodyResponse = json.decode(response.body);
    final id = bodyResponse['id'] as String;
    log('Checkout session id $id');
    return id;
  }
}
