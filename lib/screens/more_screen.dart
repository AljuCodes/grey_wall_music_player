import 'package:flutter/material.dart';
import 'package:grey_wall/audio.dart';
import 'package:grey_wall/controller/permission_controller.dart';
import 'package:grey_wall/main.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    print("333 build more ${permissionCtrl.getNotification()}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Features"),
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.notifications,
            //     size: 30,
            //   ),
            //   title: const Text("Allow Notifications"),
            //   trailing: Switch(
            //     value: permissionCtrl.getNotification(),
            //     onChanged: (value) {
            //       setState(() {
            //         print(
            //             "333 in onchanged ${permissionCtrl.getNotification()}");
            //         permissionCtrl.changeprmsn(value);
            //       });
            //     },
            //     activeColor: Colors.black,
            //   ),
            // ),
            const ListTile(
              leading: const Icon(
                Icons.access_time,
                size: 30,
              ),
              title: const Text("License"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text("Service")),
            const ListTile(
              leading: Icon(
                Icons.info,
                size: 30,
              ),
              title: Text("Privacy policy"),
            ),
            const ListTile(
              leading: Icon(
                Icons.link,
                size: 30,
              ),
              title: Text("Visit aljucodes.com"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("General"),
            ),
            InkWell(
              onTap: _showAbout,
              child: const ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                title: Text("About"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Center(
                child: Text(
              "Version v1.00",
              style: TextStyle(color: Colors.grey),
            ))
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showAbout() {
    return showDialog(
      context: context,
      builder: (context) {
        return AboutDialog(
          applicationName: "Music Player",
          applicationVersion: "Version 1.0.0",
          applicationIcon: Image.asset(
            'assets/images/icon.jpg',
            width: 60.0,
            height: 60.0,
          ),
        );
      },
    );
  }
}
