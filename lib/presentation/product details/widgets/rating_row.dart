import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  final int number;
  final double rating;

  const RatingRow({super.key, required this.number, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          child: Text(
            "$number",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, height: 1.2),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Icon(Icons.star),
        Expanded(
          child: Container(
            height: 10,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xffeff2f7),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Rating(number: number, rating: rating),
          ),
        ),
      ],
    );
  }
}

class Rating extends StatelessWidget {
  final int number;
  final double rating;
  const Rating({super.key, required this.number, required this.rating});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double parentWidth = constraint.maxWidth;
      return UnconstrainedBox(
        alignment: Alignment.topRight,
        child: Container(
          width: parentWidth * rating, // ضبط العرض بناءً على التقييم
          height: 10,
          decoration: BoxDecoration(
            color: number == 1
                ? const Color(0xffd4070e)
                : number == 2 || number == 3
                    ? const Color(0xffff952c)
                    : number == 4
                        ? const Color(0xffbed62f)
                        : const Color(0xff00a651),
          ),
        ),
      );
    });
  }
}
