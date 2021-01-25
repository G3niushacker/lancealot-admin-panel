import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GuardProfile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String uid;
  GuardProfile({this.uid, this.firstName, this.lastName});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$firstName $lastName"),
          actions: [
            MaterialButton(
              onPressed: () {
                firestore.collection('guards').doc(uid).delete();
                Navigator.pop(context);
              },
              color: Colors.red,
              child: Text(
                "Delete Profile",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: firestore.collection('guards').doc(uid).get(),
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
                        height: 80,
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
                                    "$firstName $lastName",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Total Files",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          Text("15",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Ratings",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          Text("15",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Joining Date",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          Text("15/02/2021",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.call),
                                    title: Text(
                                        "Phone: ${snapshot.data['phone']}"),
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
                                    leading: Icon(Icons.credit_card_sharp),
                                    title: Text("License No: FFFGJ12356"),
                                    subtitle: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.credit_card_sharp),
                                    title: Text("License Exp: 12/12"),
                                    subtitle: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.location_city),
                                    title:
                                        Text("City: ${snapshot.data['city']}"),
                                    subtitle: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.stacked_bar_chart),
                                    title: Text(
                                        "State: ${snapshot.data['state']}"),
                                    subtitle: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(snapshot.data['image']),
                          )),
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
        ));
  }
}
// FutureBuilder(
// future: firestore.collection('guards').doc(uid).get(),
// builder: (context,snapshot){
// if(snapshot.hasData){
// return
// }else{
// return Center(child: CircularProgressIndicator(),);
// }
// },
// ),
