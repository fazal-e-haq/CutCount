import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Sample services data
  final List<Map<String, dynamic>> services = List.generate(
    11,
    (index) => {
      'name': 'Hair Cutting',
      'price': 'Rs 150',
      'image': 'assets/images/BeardCutting.jpeg',
    },
  );

  // Current timestamp
  final DateTime now = DateTime.now();
  String two(int n) => n.toString().padLeft(2, '0');
  late final String formatted =
      '${two(DateTime.now().day)}-${two(DateTime.now().month)}-${DateTime.now().year} '
      'at ${two(DateTime.now().hour)}:${two(DateTime.now().minute)}:${two(DateTime.now().second)}';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),

            // Top greeting container
            Container(
              height: size.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.black12, Colors.white24],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffE95401),
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xffE95401),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Added: 10\nTotal: 1500',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: size.width * 0.12,
                      backgroundColor: Colors.transparent,
                      backgroundImage: const AssetImage(
                        'assets/images/pic.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            // Services title
            Text('Services', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: size.height * 0.02),

            // Services list using ListView.builder
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color(0xffE95401).withAlpha(120),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                service['image'],
                                height: size.height * 0.18,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            service['name'],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            service['price'],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffE95401),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('ADD'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
