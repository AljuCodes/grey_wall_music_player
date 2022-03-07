import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_wall/logic/notify_bloc/notify_bloc.dart';
import 'package:grey_wall/logic/song_bloc/songbloc_bloc.dart';
import 'package:grey_wall/main.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotifyBloc>(context).add(NotifyEvent.load());
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
              child: const Text("Settings"),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                size: 30,
              ),
              title: const Text("Notifications"),
              trailing: BlocBuilder<NotifyBloc, bool>(
                builder: (context, state) {
                  return Switch(
                    value: state,
                    onChanged: (value) {
                      permissionCtrl.changeNotify(value);
                      BlocProvider.of<NotifyBloc>(context)
                          .add(NotifyEvent.load());
                    },
                    activeColor: Theme.of(context).primaryColor,
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Features"),
            ),
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AboutDialog(
                      applicationName: "Grey Wall",
                      applicationVersion: "Version 1.0.0",
                      applicationIcon: Image.asset(
                        'assets/images/icon.jpeg',
                        width: 60.0,
                        height: 60.0,
                      ),
                    );
                  },
                );
              },
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
}
