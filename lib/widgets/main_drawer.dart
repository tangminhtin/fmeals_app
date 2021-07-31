import 'package:flutter/material.dart';
import 'package:fmeals_app/screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
    String text,
    IconData icon,
    BuildContext context,
    VoidCallback tapHandler,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: Theme.of(context).textTheme.title?.fontFamily,
          fontSize: Theme.of(context).textTheme.title?.fontSize,
          fontWeight: Theme.of(context).textTheme.title?.fontWeight,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'Cooking up!',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
                fontSize: 40,
              ),
            ),
          ),
          buildListTile('Meals', Icons.restaurant, context, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filters', Icons.settings, context, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
        ],
      ),
    );
  }
}
