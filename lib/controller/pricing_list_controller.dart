import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../helpers/config.dart';
import '../models/pricing_list_model.dart';

class PricingListController extends GetxController with StateMixin {
  PricingListController();

  final dio = Dio();

  List<Datum> pricingDropdownModel = [];
  List selectedAllValue = [];
  RxString selectedPlan = "0".obs;
  Map<String, String> dropdownPriceMap = {
    "Select a Plan (inclusive of GST)": "0"
  };
  int totalPrice = 0;
  int countOfSelected = 0;
  double totalDisc = 0.0;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getPriceDropdownList(packageName: "LM");
  }

  List createModelList = [
    {
      "package": "LM",
      "title": "Little Masters",
      "selected": "0",
      "subTitle": "Small cap",
      "url" : "assets/small_cap.png",
      "description":
          "Invest in up-trending Smallcap stocks screened through MILARS strategy to generate wealth."
    },
    {
      "package": "EML",
      "title": "Emerging Market Leaders",
      "selected": "0",
      "subTitle": "Mid cap",
      "url": "assets/midcap.png",
      "description":
          "Generate wealth by riding momentum in Midcap stocks screened throught MILARS strategy."
    },
    {
      "package": "LCF",
      "title": "Large Cap Focus",
      "selected": "0",
      "subTitle": "Large cap",
      "url": "assets/largecap.png",
      "description":
          "Achieve stable growth in your portfolio by investing in Bluechip stocks passed through MILARS strategy."
    }
  ];

  Future<void> getPriceDropdownList({required String packageName}) async {
    try {
      var response = await dio.request(
        "${URLs
            .BASE_URL}?action=search&activity=PricingV2&CID=984493&PKGName=$packageName",
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        final removeHtmlTags = removeAllHtmlTags(response.data);
        pricingDropdownModel =
        pricingDropdownModelFromJson(removeHtmlTags).data!;
        pricingDropdownModel.forEach((element) {
          dropdownPriceMap["${element.pDescription} - RS. ${element.pAmount}"] =
              element.pAmount;
        });
        isLoading.value = false;
        change("success", status: RxStatus.success());
      } else {}
    }catch(e){
      if(e is SocketException){
        change("error_internet_connection", status: RxStatus.error(
            "No Internet Connection," "Check Your Internet"));
      }else {
        change("error", status: RxStatus.error(
            "Something error occurred!!, Please Try again"));
      }

    }
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  void setSelectedValue({required String value, required int indexData}) {
    if (createModelList[indexData]["selected"] != "0") {
      totalPrice =
          totalPrice - int.parse(createModelList[indexData]["selected"]);
    }
    createModelList[indexData]["selected"] = value;
    totalPrice = totalPrice + int.parse(createModelList[indexData]["selected"]);
   countOfSelected = createModelList.where((element) => element["selected"] != "0").length;
   if(countOfSelected == 2){
     totalDisc = totalPrice * 0.2;
   }
    change("success", status: RxStatus.success());
  }
}
