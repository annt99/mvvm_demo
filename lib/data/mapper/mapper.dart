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
