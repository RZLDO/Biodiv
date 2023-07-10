import 'package:biodiv/utils/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyData extends StatelessWidget {
  final String textMessage;
  const EmptyData({super.key, required this.textMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'asset/image/Empty.png',
        ),
        Text(
          textMessage,
          style: GoogleFonts.poppins(color: AppColor.mainColor, fontSize: 12),
        )
      ],
    );
  }
}

class FailureState extends StatelessWidget {
  final String textMessage;
  const FailureState({super.key, required this.textMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'asset/image/wrong.png',
        ),
        Text(
          textMessage,
          style: GoogleFonts.poppins(color: AppColor.mainColor, fontSize: 18),
        )
      ],
    );
  }
}
