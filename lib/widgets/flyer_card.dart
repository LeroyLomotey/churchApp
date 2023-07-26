import 'package:flutter/material.dart';

imageCard(BuildContext context, String imageURL) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          contentPadding: const EdgeInsets.all(0),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          content: SizedBox(height: 400, child: Image.network(imageURL)),
        );
      });
}
