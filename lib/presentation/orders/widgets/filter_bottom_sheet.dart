import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSortDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildSortOption(context, 'Date: Newest First'),
          _buildSortOption(context, 'Date: Oldest First'),
          _buildSortOption(context, 'Amount: High to Low'),
          _buildSortOption(context, 'Amount: Low to High'),
        ],
      ),
    ),
  );
}

Widget _buildSortOption(BuildContext context, String title) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      // Implement sort functionality
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
