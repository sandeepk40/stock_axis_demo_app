import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockaxis/helpers/custom_card.dart';
import '../controller/pricing_list_controller.dart';


class PricingListPage extends StatelessWidget {
   PricingListPage({super.key});
  final controller = Get.put(PricingListController());

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(title: const Text("Pricing",
        style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: const Icon(Icons.arrow_back),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30)
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon( Icons.question_mark_rounded,
                  size: 21,
                color: Colors.grey,
                  ),
            ),
          )
        ],
        ),
        body:  Column(
          children: [
            controller.countOfSelected >= 2 ? Expanded(
                flex: 1,
                child: Container(
              width: MediaQuery.of(context).size.width,
                color: Colors.green,
                child: Center(child:
                Text("You will save Rs. ${controller.totalDisc.toStringAsFixed(0)} on this plan",style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16

                ),)))): Container(),
            Expanded(
                flex: 16,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: createPricingListView(context),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                              visible: controller.totalPrice == 0 ? true : false,
                              child: SizedBox(height: MediaQuery.of(context).size.width/34,)),
                          Text("Rs. ${controller.totalPrice}",
                          style: const TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19
                          ),
                          ),
                          const Text("Inclusive GST",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey
                          ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: controller.totalPrice == 0 ? Colors.grey : const Color(0xFF0D47A1),
                            foregroundColor:  Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: const Text(
                          "Proceed For Payment",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ),onLoading: Container(
        color: Colors.white,
        child: (const Center(child: CircularProgressIndicator(
          color: Color(0xFF0D47A1),
        ),))),
      onError: (error) {
      return Scaffold(body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error!,
              style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),
            ),
            SizedBox(height: MediaQuery.of(context).size.width/34,),
            ElevatedButton(
              onPressed: () {
                controller.onInit();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color(0xFF0D47A1),
                  foregroundColor:  Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text(
                "Try Again",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ));
      }
    );
  }

  Widget createPricingListView(BuildContext context){
    return controller.isLoading.value ? Container(
        color: Colors.white,
        child: (const Center(child: CircularProgressIndicator(
          color: Color(0xFF0D47A1),
        ),))) : ListView.builder(
        itemCount: controller.createModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomCardView(
            url: controller.createModelList[index]["url"],
            package: controller.createModelList[index]["package"],
              title: controller.createModelList[index]["title"],
            subTitle: controller.createModelList[index]["subTitle"],
            description: controller.createModelList[index]["description"],
            dropdownPriceMap: controller.dropdownPriceMap,
              selectedPlan: controller.createModelList[index]["selected"],
            callback: (value){
                controller.setSelectedValue(value: value, indexData: index);
            },
            dropdownCallback: (value){
              controller.isLoading.value = true;
              controller.getPriceDropdownList(packageName: value);
            },
          );
        });
  }
}
