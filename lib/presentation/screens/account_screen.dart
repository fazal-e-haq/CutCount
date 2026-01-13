import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .start,

              children: [
                SizedBox(height: size.height * 0.03),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/splash.png'),
                  radius: 60,
                ),
                SizedBox(height: size.height * 0.02),
                Text('N a m e', style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: size.height * 0.01),
                Text('Email', style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: size.height * 0.05),
                profileList(
                  context,
                  'Create Services',
                  Icons.miscellaneous_services,
                  () {},
                ),
                profileList(context, 'Privacy Policy', Icons.policy, () {}),
                profileList(context, 'Settings', Icons.settings, () {}),
                profileList(context, 'Log out', Icons.logout, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  //
  Widget profileList(
    BuildContext context,
    String title,
    IconData icon,
    void Function()? onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: .circular(10)),
        onTap: onTap,
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Icon(Icons.arrow_forward_ios),
        leading: Icon(icon),
      ),
    );
  }
}
