import 'package:emdad/layout/transporter_layout/transporter_layout.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_transporter_order_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransportProcessScreen extends StatefulWidget {
  const TransportProcessScreen({Key? key}) : super(key: key);

  @override
  State<TransportProcessScreen> createState() => _TransportProcessScreenState();
}

int initialProcessValue = 0;

class _TransportProcessScreenState extends State<TransportProcessScreen> {

  @override
  void initState() {
    super.initState();
    initialProcessValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: CustomText(
          text: 'عمليه توصيل',
          textStyle: primaryTextStyle().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            const CustomTransporterOrderListTile(
              clientImageUrl:
                  'https://tse1.mm.bing.net/th?id=OIP.L3uZEm5nXG-UtEGXNL8tFQHaFj&pid=Api&P=0&w=244&h=183',
              clientName: 'محمد احمد',
              clientCompanyName: 'زاد',
              address: 'العنوان',
            ),
            SizedBox(height: 40.h),
            Container(
              child: initialProcessValue != 1 &&
                      initialProcessValue != 2 &&
                      initialProcessValue != 3
                  ? CustomButton(
                      width: 280.w,
                      text: 'تم الوصول الي مكان الالتقاط',
                      textStyle: thirdTextStyle().copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      onPressed: () {
                        setState(() {
                          initialProcessValue++;
                          print(initialProcessValue);
                        });
                      },
                    )
                  : Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        CustomButton(
                          width: 280.w,
                          text: 'تم الوصول الي موقع الإلتقاط',
                          textStyle: thirdTextStyle().copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          onPressed: () {},
                          backgroundColor: AppColors.textButtonColor.withOpacity(0.5),
                        ),
                        Container(
                          width: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: const Color(0xff1CAF17),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            SizedBox(height: 30.h),
            const CustomTransporterOrderListTile(
              clientImageUrl:
                  'https://tse1.mm.bing.net/th?id=OIP.L3uZEm5nXG-UtEGXNL8tFQHaFj&pid=Api&P=0&w=244&h=183',
              clientName: 'محمد احمد',
              clientCompanyName: 'زاد',
              address: 'العنوان',
            ),
            SizedBox(height: 30.h),
            Container(
              child: initialProcessValue != 2 && initialProcessValue != 3
                  ? CustomButton(
                      width: 280.w,
                      text: 'تم الوصول الي موقع التوصيل',
                      textStyle: thirdTextStyle().copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      onPressed: () {
                        setState(() {
                          initialProcessValue++;
                          print(initialProcessValue);
                        });
                      },
                    )
                  : Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        CustomButton(
                          width: 280.w,
                          text: 'تم الوصول الي موقع التوصيل',
                          textStyle: thirdTextStyle().copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          onPressed: () {},
                          backgroundColor: AppColors.textButtonColor.withOpacity(0.5),
                        ),
                        Container(
                          width: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: const Color(0xff1CAF17),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            SizedBox(height: 50.h),
            CustomButton(
              width: 170.w,
              text: 'تأكيد أنتهاء العملية',
              backgroundColor: Colors.red,
              textStyle: thirdTextStyle()
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: CustomText(
                            text: 'تم الانتهاء من التوصيل بنجاح',
                            textStyle: thirdTextStyle()
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          content: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: const Color(0xff39AA2D),
                            child: const Icon(Icons.check, color: Colors.white),
                          ),
                          actions: <Widget>[
                            CustomButton(
                              width: 215.w,
                              text: 'إغلاق',
                              backgroundColor: Colors.red,
                              textStyle: thirdTextStyle().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                                navigateToAndFinish(
                                    context, const TransporterLayout());
                              },
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.center,
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClickedButton() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        CustomButton(
          width: 280.w,
          text: 'تم الوصول الي موقع التوصيل',
          textStyle: thirdTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          onPressed: () {},
          backgroundColor: AppColors.textButtonColor.withOpacity(0.5),
        ),
        Container(
          width: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: const Color(0xff1CAF17),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
