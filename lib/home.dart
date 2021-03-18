import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PageState());
    final state = Get.find<PageState>();
    final controller = PageController(viewportFraction: 0.9);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            state.page.value = controller.page;
          }
          return true;
        },
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          itemCount: 100,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Item(index),
        ),
      ),
    );
  }
}

class PageState extends GetxController {
  final page = 0.0.obs;
}

class Item extends StatelessWidget {
  final int index;
  final state = Get.find<PageState>();

  Item(this.index);

  @override
  Widget build(BuildContext context) {
    final child = Card(
      elevation: 8,
      shadowColor: Colors.black54,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      clipBehavior: Clip.hardEdge,
      child: _Item(index),
    );
    return Obx(() {
      final scale = index - (state.page.value ?? 0);
      return Transform.scale(
        alignment: Alignment.topCenter,
        scale: 1 - 0.3 * scale.abs(),
        child: child,
      );
    });
  }
}

class _Item extends StatelessWidget {
  final int index;
  final state = Get.find<PageState>();

  _Item(this.index);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;
    return Stack(children: [
      SizedBox(
        width: width,
        height: width * 2,
        child: CachedNetworkImage(
          imageUrl: 'https://loremflickr.com/400/800?$index',
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: const Text('事件追踪'),
            ),
            const SizedBox(height: 8),
            const Text(
              '一套 Flutter 混排瀑布流解决方案',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      ),
      Positioned(
        height: 220,
        width: width,
        bottom: 0,
        child: ClipPath(
          clipper: const TriangleClipper(),
          clipBehavior: Clip.hardEdge,
          child: Container(color: Colors.white),
        ),
      ),
      Positioned(
        bottom: 64,
        width: width,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: const Border.fromBorderSide(
                    BorderSide(width: 2),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: const Text('昨天', style: TextStyle(fontSize: 12)),
              ),
            ]),
            const SizedBox(height: 16),
            const Text(
              // ignore: lines_longer_than_80_chars
              '流式布局，这是一种当前无论是前端，还是 Native 都比较流行的一种页面布局。特别是对于商品这样的 Feeds 流，无论是淘宝，京东，美团，还是闲鱼。都基本上以多列瀑布流进行呈现，容器列数固定，然后每个卡片高度不一，形成参差不齐的多栏布局。',
              maxLines: 3,
            ),
          ]),
        ),
      ),
      Positioned(
        bottom: 16,
        width: width,
        child: Container(
          height: 100,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white10, Colors.white],
              stops: [0, 0.3],
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('查看详情'),
          ),
        ),
      ),
      Obx(() {
        final scale = index - (state.page.value ?? 0);
        return Container(color: Colors.white.withOpacity(0.5 * scale.abs()));
      }),
    ]);
  }
}

class TriangleClipper extends CustomClipper<Path> {
  const TriangleClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 70);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}
