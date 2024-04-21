import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_finder/models.dart';
import 'package:image_finder/ui/constants/app_colors.dart';
import 'package:image_finder/ui/widgets/image_view.dart';
import 'package:image_finder/utils/extensions.dart';

class ImageViewPage extends StatelessWidget {
  static const String routeName = "image";
  const ImageViewPage({
    super.key,
    required this.image,
  });

  final ImageItem image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const CircleAvatar(
            backgroundColor: AppColor.primary,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Hero(
          tag: image.id,
          child: ImageView(
            previewUrl: image.previewUrl,
            imageUrl: image.url,
          ),
        ),
      ),
    );
  }
}
