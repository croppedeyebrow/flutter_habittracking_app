import 'package:flutter/material.dart';

class HabitDrawer extends StatelessWidget {
  const HabitDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/ai프로필.png'),
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/spaceman.png'),
              )
            ],
            accountName: Text('코딩지휘소'),
            accountEmail: Text('lee940706@gmail.com'),
            onDetailsPressed: () {},
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent[200],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            iconColor: Colors.purple,
            focusColor: Colors.purple,
            title: Text('홈'),
            onTap: () {},
            trailing: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
