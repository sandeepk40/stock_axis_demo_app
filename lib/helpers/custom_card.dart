import 'package:flutter/material.dart';

class CustomCardView extends StatelessWidget {
  final String url;
  final String title;
  final String subTitle;
  final String description;
  final Map<String, String> dropdownPriceMap;
  final String selectedPlan;
  final Function callback;
  final Function dropdownCallback;
  final String package;

  const CustomCardView({super.key,
    required this.url,
    required this.package,
    required this.dropdownCallback,
    required this.title, required this.subTitle, required this.description, required this.dropdownPriceMap, required this.selectedPlan, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15,left: 5,right: 5),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(url,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                          style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                        Text(subTitle,
                          style: const TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.info_outline_rounded,
                  size: 30,
                  color: Colors.grey,
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width/34,),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
            ),
            SizedBox(height: MediaQuery.of(context).size.width/34,),
            Text(description),
            SizedBox(height: MediaQuery.of(context).size.width/31,),
            DropdownButtonFormField(
              onTap: (){
                dropdownCallback(package);
              },
              isDense: true,
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_drop_down_sharp,
                size: 22,),
              ),
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.green,),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 5.5, 0, 0),
                  labelText: "",
                  border: OutlineInputBorder()),
              items: dropdownPriceMap.entries.map((value) {
                return DropdownMenuItem(
                    value: value.value, child: Text(value.key));
              }).toList(),
              value: selectedPlan,
              onChanged: (dynamic value) {
                callback(value);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.width/57,),
          ],
        ),
      ),
    );
  }
}
