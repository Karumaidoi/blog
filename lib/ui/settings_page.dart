import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../provider/theme_provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? image;
  bool value = true;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    // ignore: unused_element
    void launchEmail(email) async {
      String url = 'mailto:$email';

      await canLaunch(url) ? launch(url) : print('Unable');
    }

    return Scaffold(
      // backgroundColor: ColorsConsts.backgroundColor,
      appBar: AppBar(
        leading: Icon(
          MaterialIcons.settings,
          color: Theme.of(context).backgroundColor,
          // size: 19,
        ),
        title: RichText(
          text: TextSpan(
            text: 'Settings',
            style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontSize: 15,
                fontFamily: ''),
            children: <TextSpan>[
              TextSpan(
                  text: '',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Sofia',
                      color: Colors.green.shade200)),
            ],
          ),
        ),
        actions: [
          PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).buttonColor,
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Row(
                      children: [
                        InkWell(
                            child: InkWell(
                                onTap: () {
                                  launchEmail('mainahmwangi12@gmail.com');
                                },
                                child: const Text('Contact Developer')))
                      ],
                    )),
                    PopupMenuItem(
                        child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              launchEmail('mainahmwangi12@gmail.com');
                            },
                            child: Text('Report a problem'))
                      ],
                    ))
                  ])
        ],
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45,
                    child: const Center(
                      child: Text(
                          'If you enjoy using TaskMate Linux, please leave a review. It really helps.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            height: 1.25,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5),
                      child: Row(
                        children: const [
                          Text(
                            'Choose Theme',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.mode_night_outlined),
                              title: const Text(
                                'Change your app\'s theme',
                                style: TextStyle(fontSize: 13),
                              ),
                              subtitle: const Text(
                                  'Toggle the switch to change your theme settings.'),
                              trailing: Switch(
                                value: themeChange.darkTheme,
                                onChanged: (value) {
                                  setState(() {
                                    themeChange.darkTheme = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 15),
                      child: Row(
                        children: const [
                          Text('USAGE INFO',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Text(
                              'To personalize your experience and provide product features, this prosuct sends Bestypie about how you use it.',
                              style: TextStyle(fontSize: 13, height: 2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5),
                            child: Row(
                              children: [
                                const Text('Send usage info'),
                                const Spacer(),
                                Switch.adaptive(
                                  value: value,
                                  onChanged: (value) => setState(() {
                                    this.value = value;
                                  }),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0, left: 12),
                      child: Row(
                        children: const [
                          Text(
                            'TERMS & CONDITIONS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                showAboutDialog(
                                  context: context,
                                  applicationName: 'Qr Code',
                                  applicationLegalese:
                                      'QR Code app provides you with best seamless experience. All rights reserved.',
                                  applicationIcon: const Image(
                                    image: AssetImage('assets/Linux.png'),
                                    width: 28,
                                  ),
                                );
                              },
                              child: const Text('Licences',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )
              ]),
        ],
      ),
    );
  }
}