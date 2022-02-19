import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
             Container(
               margin: const EdgeInsets.only(left: 20),
               child: 
            const Text("General"),),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 30,
              ),
              title: Text("About"),
            ),

            // 
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            // 
            // 
            const SizedBox(height: 30,),
             Container(
               margin: const EdgeInsets.only(left: 20),
               child: 
            const Text("Features"),),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                size: 30,
              ),
              title: const Text("Allow Notifications"),
              trailing: Switch(value: true, onChanged: (value){},activeColor: Colors.black,),
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
            const SizedBox(height: 30,),
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
            const SizedBox(height: 50,),
            const Center(child: Text("Version v1.00",style: TextStyle(color: Colors.grey),))
          ],
        ),
      ),
    );
  }
}
