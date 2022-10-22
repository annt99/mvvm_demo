class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotification;
  Customer(this.id, this.name, this.numOfNotification);
}

class Contact {
  String phone;
  String email;
  String link;
  Contact(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contact? contact;
  Authentication(this.customer, this.contact);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}
