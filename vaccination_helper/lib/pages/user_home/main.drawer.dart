import 'package:flutter/material.dart';
import 'package:vaccination_helper/pages/login_singup/login_singup.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.cyan[800],
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/user.png'))),
                  ),
                  Text(
                    'Anonymous',
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 22,
                        color: Colors.white),
                  ),
                  Text(
                    'Anonymous@example.com',
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(fontFamily: 'Comfortaa', fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontFamily: 'Comfortaa', fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Log Out',
              style: TextStyle(fontFamily: 'Comfortaa', fontSize: 18),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
