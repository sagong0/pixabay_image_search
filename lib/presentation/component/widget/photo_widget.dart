import 'package:flutter/material.dart';
import 'package:image_search/domain/model/photo.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;

  const PhotoWidget({
    required this.photo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: NetworkImage(
            photo.previewURL,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
