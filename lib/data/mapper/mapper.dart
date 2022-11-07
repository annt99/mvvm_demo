// to convert the response into a non nullable object (model)

// ignore_for_file: constant_identifier_names

import 'package:mvvm_demo/app/extensions.dart';
import 'package:mvvm_demo/data/response/responses.dart';
import 'package:mvvm_demo/domain/model/model.dart';

const EMPTY = "";

const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotification?.orZero() ?? ZERO);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(this?.phone?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? "", this?.link?.orEmpty() ?? "");
  }
}

extension AuthenticationResponseMapper on AuthenticaitonResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgetPasswordResponse? {
  String toDomain() {
    return this?.support.orEmpty() ?? EMPTY;
  }
}

extension RegisterResponseMapper on RegisterResponse? {
  Register toDomain() {
    return Register(this?.customer.toDomain(), this?.contact.toDomain());
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(this?.id.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(this?.id.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAD toDomain() {
    return BannerAD(this?.id.orZero() ?? ZERO, this?.link?.orEmpty() ?? EMPTY,
        this?.title?.orEmpty() ?? EMPTY, this?.image?.orEmpty() ?? EMPTY);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                const Iterable.empty().cast<Service>())
            .toList();
    List<BannerAD> mappedBanners =
        (this?.data?.banners?.map((banner) => banner.toDomain()) ??
                const Iterable.empty().cast<BannerAD>())
            .toList();
    List<Store> mappedStores =
        (this?.data?.stores?.map((store) => store.toDomain()) ??
                const Iterable.empty().cast<Store>())
            .toList();
    var data = HomeData(mappedServices, mappedStores, mappedBanners);
    return HomeObject(data);
  }
}
