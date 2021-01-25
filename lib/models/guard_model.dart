class Guard_Model {
  double latitude, longitude;
  String firstName, lastName, uid;
  String phone;
  String image;

  Guard_Model(
      {this.latitude,
      this.longitude,
      this.firstName,
      this.lastName,
      this.uid,
      this.phone,
      this.image});

  factory Guard_Model.fromMap(Map<String, dynamic> map) {
    return new Guard_Model(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      uid: map['uid'] as String,
      phone: map['phone'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'uid': this.uid,
      'phone': this.phone,
      'image': this.image,
    } as Map<String, dynamic>;
  }
}
