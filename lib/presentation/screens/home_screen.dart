import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const .symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: size.height * 0.05),
              Container(
                height: size.height * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ Colors.black12,Colors.white24],
                  ),
                  borderRadius: .circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffE95401),
                      blurRadius: 2,
                      blurStyle: .outer,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const .all(18.0),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Hi,\n',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                ),
                                TextSpan(
                                  text: 'FAZAL',
                                  style: GoogleFonts.aclonica(
                                    fontSize: 30,
                                    fontWeight: .w900,
                                    color: Color(0xffE95401),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            'A d d e d   :   10\nT o t a l   :   1500',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/pic.png'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Services',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: size.height * 0.02),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
              _servicesCard(context),
            ],
          ),
        ),
      ),
    );
  }



  Widget _servicesCard(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      child: Card(
        shadowColor: Colors.black,

        elevation: 10,
        color: Color(0xffE95401).withAlpha(120),
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
        child: Padding(
          padding: const .symmetric(horizontal: 10, vertical: 10),
          child: Expanded(
            child: Column(
              crossAxisAlignment: .stretch,
              mainAxisAlignment: .center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: .circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/BeardCutting.jpeg',
                    height: 150,
                  ),
                ),

                Text(
                  'Hair cutting',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text('Rs 150', style: Theme.of(context).textTheme.bodyLarge),
                ElevatedButton(onPressed: () {}, child: Text('A D D')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
