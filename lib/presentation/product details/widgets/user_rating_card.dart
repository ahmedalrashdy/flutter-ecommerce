import 'package:flutter/material.dart';

import '../../../core/widgets/ExpandedText.dart';

class UserRatingCard extends StatelessWidget {
  const UserRatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            "assets/images/product.png",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ahmed Alrashdy",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Color(0xffffc82c), size: 30),
                  Icon(Icons.star, color: Color(0xffffc82c), size: 30),
                  Icon(Icons.star, color: Color(0xffffc82c), size: 30),
                  Icon(Icons.star, color: Color(0xffffc82c), size: 30),
                  Icon(Icons.star, color: Color(0xffffc82c), size: 30),
                  Spacer(),
                  Text(
                    "12:30 am",
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ExpandedText(
                  maxLines: 3,
                  style: const TextStyle(color: Colors.black38),
                  text:
                      "إذا كان لديك 10 مستخدمين، يمكن حساب التقييم النهائي بنفس الطريقةإذا كان لديك 10 مستخدمين، يمكن حساب التقييم النهائي بنفس الطريقة باستخدام المتوسط الحسابي. سأوضح لك مثالاً مفصلاً بالإضافة إلى الكود لحساب التقييم النهائي. باستخدام المتوسط الحسابي. سأوضح لك مثالاً مفصلاً بالإضافة إلى الكود لحساب التقييم النهائي."),
            ],
          ),
        ),
      ],
    );
  }
}
