// To parse this JSON data, do
//
//     final pricingDropdownModel = pricingDropdownModelFromJson(jsonString);

import 'dart:convert';

PricingDropdownModel pricingDropdownModelFromJson(String str) => PricingDropdownModel.fromJson(json.decode(str));

String pricingDropdownModelToJson(PricingDropdownModel data) => json.encode(data.toJson());

class PricingDropdownModel {
  List<Datum>? data;

  PricingDropdownModel({
     this.data,
  });

  factory PricingDropdownModel.fromJson(Map<String, dynamic> json) => PricingDropdownModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String pCode;
  String pDescription;
  String pAmount;
  String pDuration;
  String pkgName;
  String comboOffer;
  String alertMsg;
  String couponCode;
  int srNo;
  String pTotaAmount;

  Datum({
    required this.pCode,
    required this.pDescription,
    required this.pAmount,
    required this.pDuration,
    required this.pkgName,
    required this.comboOffer,
    required this.alertMsg,
    required this.couponCode,
    required this.srNo,
    required this.pTotaAmount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    pCode: json["PCode"],
    pDescription: json["PDescription"],
    pAmount: json["PAmount"],
    pDuration: json["PDuration"],
    pkgName: json["PKGName"],
    comboOffer: json["ComboOffer"],
    alertMsg: json["AlertMsg"],
    couponCode: json["CouponCode"],
    srNo: json["SrNo"],
    pTotaAmount: json["PTotaAmount"],
  );

  Map<String, dynamic> toJson() => {
    "PCode": pCode,
    "PDescription": pDescription,
    "PAmount": pAmount,
    "PDuration": pDuration,
    "PKGName": pkgName,
    "ComboOffer": comboOffer,
    "AlertMsg": alertMsg,
    "CouponCode": couponCode,
    "SrNo": srNo,
    "PTotaAmount": pTotaAmount,
  };
}
