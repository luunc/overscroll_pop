import 'package:flutter/material.dart';

import 'package:overscroll_pop/overscroll_pop.dart';

class HorizontalScrollView extends StatelessWidget {
  final ScrollToPopOption scrollToPopOption;
  final DragToPopDirection? dragToPopDirection;

  const HorizontalScrollView({
    Key? key,
    this.scrollToPopOption = ScrollToPopOption.start,
    this.dragToPopDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverscrollPop(
      scrollToPopOption: scrollToPopOption,
      dragToPopDirection: dragToPopDirection,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Hero(
              tag: 'h $scrollToPopOption${dragToPopDirection ?? ''}',
              child: AppBar(
                title: Text(
                  'Horizontal ScrollView',
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
          body: PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, index) => Container(
              color: index % 2 == 0 ? Colors.cyanAccent : Colors.orangeAccent,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Page: $index'),
                    Text('$scrollToPopOption'),
                    if (dragToPopDirection != null)
                      Text(dragToPopDirection.toString()),
                  ],
                ),
              ),
            ),
            itemCount: 3,
          ),
        ),
      ),
    );
  }
}
