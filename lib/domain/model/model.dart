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

class Register {
  Customer? customer;
  Contact? contact;
  Register(this.customer, this.contact);
}

class Service {
  int id;
  String title;
  String image;
  Service(this.id, this.title, this.image);
}

class BannerAD {
  int id;
  String link;
  String title;
  String image;
  BannerAD(this.id, this.link, this.title, this.image);
}

class Store {
  int id;
  String title;
  String image;
  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<Store> stores;
  List<BannerAD> banners;
  HomeData(this.services, this.stores, this.banners);
}

class HomeObject {
  HomeData data;
  HomeObject(this.data);
}
