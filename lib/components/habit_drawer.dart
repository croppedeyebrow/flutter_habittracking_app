import 'package:flutter/material.dart';

class HabitDrawer extends StatelessWidget {
  const HabitDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
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
                    color: Color.fromARGB(255, 139, 184, 255),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.calendar_month),
                      iconColor: Color.fromARGB(255, 139, 184, 255),
                      focusColor: Colors.purple,
                      title: Text('달력'),
                      onTap: () {},
                      trailing: Icon(Icons.navigate_next),
                    ),
                    ListTile(
                      leading: Icon(Icons.data_thresholding),
                      iconColor: Color.fromARGB(255, 139, 184, 255),
                      focusColor: Colors.purple,
                      title: Text('습관 달성률'),
                      onTap: () {},
                      trailing: Icon(Icons.navigate_next),
                    ),
                    ListTile(
                      leading: Icon(Icons.co_present_outlined),
                      iconColor: Color.fromARGB(255, 139, 184, 255),
                      focusColor: Colors.purple,
                      title: Text('습관 지키지 팀'),
                      onTap: () {},
                      trailing: Icon(Icons.navigate_next),
                    ),
                    ListTile(
                      leading: Icon(Icons.restore_from_trash),
                      iconColor: Color.fromARGB(255, 139, 184, 255),
                      focusColor: Colors.purple,
                      title: Text('휴지통'),
                      onTap: () {},
                      trailing: Icon(Icons.navigate_next),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      iconColor: Color.fromARGB(255, 139, 184, 255),
                      focusColor: Colors.purple,
                      title: Text('설정'),
                      onTap: () {},
                      trailing: Icon(Icons.navigate_next),
                    ),
                    ListTile(
                      leading: Icon(Icons.key_off_outlined),
                      iconColor: Color.fromARGB(255, 139, 184, 255),
                      focusColor: Colors.purple,
                      title: Text('로그아웃'),
                      onTap: () {},
                      trailing: Icon(Icons.navigate_next),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
