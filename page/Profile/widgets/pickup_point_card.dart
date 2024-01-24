import 'package:courier_app/logic/ProfileProvider/provider.dart';
import 'package:courier_app/page/PickupAndBankDetails/PickupDetails.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PickupPointCardWidget extends StatelessWidget {
  const PickupPointCardWidget({
    super.key,
    required this.stateAction,
    required this.index,
  });
  final ProfileProvider stateAction;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 40.w,
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Title: ${stateAction.pickupPoints[index].name}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final data = stateAction.pickupPoints[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PickupDetails(
                              id: data.id!,
                              name: data.name,
                              address: data.address,
                              isUpdate: true,
                              districtID: data.districtId,
                              upazillaID: data.upazillaId,
                              backToProfile: true,
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                    // if (stateAction.pickupPoints.length > 1)
                    //   GestureDetector(
                    //     onTap: () {
                    //       stateAction.deletePickupPoint(
                    //           context, stateAction.pickupPoints[index].id!);
                    //     },
                    //     child: Icon(
                    //       Icons.delete,
                    //       color: Colors.red,
                    //     ),
                    //   )
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "Address: ${stateAction.pickupPoints[index].address}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "District: ${stateAction.pickupPoints[index].district}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "Area: ${stateAction.pickupPoints[index].upazilla}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
