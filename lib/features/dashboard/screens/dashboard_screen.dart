import 'package:cut_count/core/widgets/app_ui.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/core/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppUi(
      topCard: TopCard(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.fromLTRB(30, 10, 16, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                DashboardCard(
                  icon: Icon(Icons.today),
                  title: 'Today cut',
                  subTitle: '12',
                  color: Colors.white70,
                ),
                DashboardCard(
                  icon: Icon(Icons.price_check),
                  title: 'Today cut',
                  subTitle: '12',
                  color: Colors.white70,
                ),
              ],
            ),
            Row(
              children: [
                DashboardCard(
                  icon: Icon(Icons.safety_divider),
                  title: 'Today cut',
                  subTitle: '12',
                  color: Colors.white70,
                ),
                DashboardCard(
                  icon: Icon(Icons.safety_divider),
                  title: 'Today cut',
                  subTitle: '12',
                  color: Colors.white70,
                ),
              ],
            ),
          ],
        ),
      ),
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Services', style: Theme.of(context).textTheme.headlineSmall),
            TextButton(onPressed: () {}, child: Text('View')),
          ],
        ),

        SizedBox(
          height: size.height * 0.15,
          child: ListView.builder(
            scrollDirection: .horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return DashboardCard(
                color: Colors.blue,
                title: 'fade',
                subTitle: '700',
                icon: Icon(Icons.wheelchair_pickup_rounded),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today short history',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(onPressed: () {}, child: Text('View')),
          ],
        ),

        Column(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: CustomListTile(
                title: Text('fade'),
                subTitle: Text('278'),
                trailing: Text('data'),
              ),
            );
          }),
        ),
      ],
    );
  }
}
