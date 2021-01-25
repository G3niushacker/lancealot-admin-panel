import 'package:flutter/material.dart';
import 'package:lancealot_admin_panel/routes/routes_names.dart';

class OnlineGuards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Guards"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, seeProfiles);
                  },
                  leading: Icon(Icons.person),
                  title: Text("See Profiles"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, mapScreen);
                  },
                  leading: Icon(Icons.map),
                  title: Text("See On Map"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
