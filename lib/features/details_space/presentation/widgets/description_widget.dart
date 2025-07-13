import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart'; // Import animate_do
import 'package:intl/intl.dart';
import 'package:workspace/features/all_space/presentation/widgets/all_item_space_widget.dart';
import 'package:workspace/features/details_space/data/model/details_space_model.dart';
import 'package:workspace/utils/routing.dart';

class DescriptionWidget extends StatelessWidget {
  final String? text;
 final  List<SuggestSpaces> suggestSpaces;
  const DescriptionWidget({this.text, super.key,
  required this.suggestSpaces,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Animated title
        FadeIn(
          duration: Duration(milliseconds: 500),
          child: Text(
            'الوصف',
            style: GoogleFonts.tajawal(
              color: const Color(0xFF32B599),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 22.h),

        // Animated description text
        FadeIn(
          duration: Duration(milliseconds: 600),
          child: Html(
            data: text,
            style: {
              "p": Style(
                fontFamily: GoogleFonts.tajawal().fontFamily,

                fontSize: FontSize(16.0.sp),
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121),
              ),
              "a": Style(
                fontFamily: GoogleFonts.tajawal().fontFamily,
                color: Colors.black,
                textDecoration: TextDecoration.underline,
                fontSize: FontSize(16.0.sp),
              ),
              "h1": Style(
                fontFamily: GoogleFonts.tajawal().fontFamily,
                fontSize: FontSize(24.0.sp),
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            },
          ),
        ),
        SizedBox(height: suggestSpaces.isNotEmpty ? 8.h : 0.h),

        // Animated section title
      suggestSpaces.isNotEmpty ?   SlideInUp(
          duration: Duration(milliseconds: 700),
          child: Text(
            'المساحات المقترحة',
            style: GoogleFonts.tajawal(
              color: const Color(0xFF212121),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ):SizedBox.shrink(),
        SizedBox(height:suggestSpaces.isNotEmpty ? 24.h : 0.h),

        // Animated widget for AllItemSpaceWidget


        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>  SlideInUp(
          duration: Duration(milliseconds: 800),
          child: AllItemSpaceWidget(
            onTap: ()=>Get.offNamedUntil(
  AppRouting.detailsView,
  (route) => route.settings.name == AppRouting.btnNavView,
  arguments: suggestSpaces[index].id!,
),
            id: suggestSpaces[index].id!,
            address: suggestSpaces[index].address ?? '',
            available:'${formatTime(suggestSpaces[index].availableFrom)} - ${formatTime(suggestSpaces[index].availableTo)}',
            email: suggestSpaces[index].email ?? '',
            image: suggestSpaces[index].mainImageUrl ?? '',
            mobile: suggestSpaces[index].mobile ?? '',
            nameCompany: suggestSpaces[index].company?.name ?? '',
            ratingAverage: '${suggestSpaces[index].ratingAverage ?? '0'}',
            ratingCount: '${suggestSpaces[index].ratingCount ?? '0'}',
            typeTitle:   suggestSpaces[index].company?.typeTitle ?? '-',
          ),
        ),
          separatorBuilder: (context, index) => SizedBox(height: 8.h,),
          itemCount: suggestSpaces.length),

      ],
    );
  }

    String formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '---';

    try {
      // نحول am/pm إلى AM/PM
      timeStr = timeStr.toUpperCase();

      final inputFormat = DateFormat('hh:mm a');
      final dateTime = inputFormat.parse(timeStr);

      final formatted = DateFormat('hh:mm a').format(dateTime);

      // نحول AM/PM إلى صباحًا/مساءً
      return formatted.contains('AM')
          ? formatted.replaceAll('AM', 'صباحًا')
          : formatted.replaceAll('PM', 'مساءً');
    } catch (e) {
      print("Error parsing time: $e");
      return '---';
    }
  }
}
