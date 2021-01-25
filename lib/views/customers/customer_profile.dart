import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class CustomerProfiles extends StatelessWidget {
  final String uid;
  final String name;
  CustomerProfiles({this.uid, this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          MaterialButton(
            onPressed: () {
              firestore.collection('customers').doc(uid).delete();
              Navigator.pop(context);
            },
            color: Colors.red,
            child: Text(
              "Delet Profile",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: firestore.collection('customers').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Card(
                        color: Colors.lightBlueAccent,
                        elevation: 5.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 800,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                Text(
                                  "$name",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ListTile(
                                  leading: Icon(Icons.call),
                                  title:
                                      Text("Phone: ${snapshot.data['phone']}"),
                                  subtitle: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.mail),
                                  title:
                                      Text("Mail: ${snapshot.data['email']}"),
                                  subtitle: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.location_city),
                                  title: Text(
                                      "Address: ${snapshot.data['house']} ${snapshot.data['state']} ${snapshot.data['city']}"),
                                  subtitle: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text(
                                      "Ring Camera: ${snapshot.data['ringCamera']}"),
                                  subtitle: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                snapshot.data['ringCamera'] == 'No'
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Email : ${snapshot.data['ringEmail']}"),
                                          Text(
                                              "Password : ${snapshot.data['ringPassword']}"),
                                        ],
                                      ),
                                ListTile(
                                  leading: Icon(Icons.business),
                                  title: Text(
                                      "Business Secure: ${snapshot.data['secureBusiness']}"),
                                  subtitle: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                snapshot.data['secureBusiness'] == 'No'
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "House : ${snapshot.data['businessHouse']}   State : ${snapshot.data['businessState']}"),
                                          Text(
                                              "City : ${snapshot.data['businessCity']}  Zip Code: ${snapshot.data['businessZip']}"),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
