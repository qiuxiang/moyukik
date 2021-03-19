import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'item.dart';

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
