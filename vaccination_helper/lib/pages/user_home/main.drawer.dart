import 'package:flutter/material.dart';
import 'package:vaccination_helper/core/user/user_entity.dart';
import 'package:vaccination_helper/helpers/types.dart';
import 'package:vaccination_helper/pages/login_singup/login_singup.dart';

class MainDrawer extends StatelessWidget {
  final UserEntity user;

  final BuildContextFunction logout;

  MainDrawer({this.user, this.logout});

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
                    user.fullName,
                    style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 22,
                        color: Colors.white),
                  ),
                  Text(
                    user.email,
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
            leading: Icon(Icons.qr_code),
            title: Text(
              'Your QR code',
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
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }
}
