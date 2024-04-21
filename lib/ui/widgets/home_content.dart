import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_finder/models.dart';
import 'package:image_finder/ui/constants/app_colors.dart';
import 'package:image_finder/ui/pages/image_view_page.dart';
import 'package:image_finder/ui/widgets/animated_text_field.dart';
import 'package:image_finder/ui/widgets/image_view.dart';
import 'package:image_finder/utils/extensions.dart';
import 'package:image_finder/utils/images_impl.dart';
import 'package:image_finder/utils/screen_break_points.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final ScrollController scrollController = ScrollController();
  final List<ImageItem> _images = [];
  String _query = "";
  late bool _loading;
  late bool _allLoaded;

  int get pageSize => ScreenBreakpoints.isExtraLargeScreen(context)
      ? 24
      : ScreenBreakpoints.isLargeScreen(context)
          ? 16
          : 10;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _allLoaded = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchImages();
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          !_allLoaded) {
        fetchImages();
      }
    });
  }

  void updateSearchQuery(String? query) {
    if (query == null) return;
    EasyDebounce.debounce('search_query', const Duration(milliseconds: 800),
        () {
      _query = query;
      _images.clear();
      setState(() {});
      fetchImages();
    });
  }

  Future<void> fetchImages() async {
    _loading = true;
    setState(() {});
    var newImages = await ImagesImplementation.fetchPaginatedImages(
      _query,
      offset: _images.length,
      pageSize: pageSize,
    );
    _loading = false;
    if (newImages.length < pageSize) {
      _allLoaded = true;
    }
    _images.addAll(newImages);
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.topPadding),
        Container(
          height: context.height * 0.1,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Align(
            alignment: Alignment.center,
            child: AnimatedTextField(
              onChanged: updateSearchQuery,
              prefixIcon: Icons.search_rounded,
              hintText: "Search images..",
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: fetchImages,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: _getContent(),
          ),
        ),
        if (_loading && _images.isNotEmpty)
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(12),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _getContent() {
    if (_loading && _images.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_images.isEmpty) {
      return const Center(
        child: Text(
          "Images are not available based on searched query. Try updating the query.",
          textAlign: TextAlign.center,
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ScreenBreakpoints.getGridCrossAxisCount(context),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          padding: const EdgeInsets.all(8.0),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () => context.go(
                  ImageViewPage.routeName.path,
                  extra: _images[index],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Hero(
                          tag: _images[index].id,
                          child: ImageView(
                            previewUrl: _images[index].previewUrl,
                            imageUrl: _images[index].url,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.thumb_up_off_alt_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${_images[index].likes}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${_images[index].views}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
