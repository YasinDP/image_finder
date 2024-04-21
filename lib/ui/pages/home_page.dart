import 'package:flutter/material.dart';
import 'package:image_finder/ui/widgets/home_content.dart';
import 'package:image_finder/utils/extensions.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    final double height = context.height;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/logo.png"),
        actions: [Image.asset("assets/avatar.png")],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: context.topPadding + height * 0.1 + 52,
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
              ),
            ),
            const HomeContent(),
          ],
        ),
      ),
    );
  }
}
