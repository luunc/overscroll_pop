import 'package:flutter/material.dart';

import 'package:overscroll_pop/overscroll_pop.dart';

import 'package:overscroll_pop_example/full_screen_drag_to_pop_example.dart';
import 'package:overscroll_pop_example/hero_animation_asset.dart';
import 'package:overscroll_pop_example/horizontal_scrollview.dart';
import 'package:overscroll_pop_example/vertical_scrollview.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (c) => Scaffold(
          appBar: AppBar(
            title: const Text('Overscroll Example'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(c).size.width,
                  height: 32.0,
                ),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    final Hero toHero = toHeroContext.widget as Hero;
                    return SizeTransition(
                      sizeFactor: animation,
                      child: toHero.child,
                    );
                  },
                  tag: ScrollToPopOption.start.toString(),
                  child: ElevatedButton(
                    onPressed: () => pushOverscrollRoute(
                      context: c,
                      scrollToPopOption: ScrollToPopOption.start,
                      child: VerticalScrollView(
                        scrollToPopOption: ScrollToPopOption.start,
                      ),
                    ),
                    child:
                        Text('Vertical scroll view ${ScrollToPopOption.start}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag: ScrollToPopOption.end.toString(),
                  child: ElevatedButton(
                    onPressed: () => pushOverscrollRoute(
                      context: c,
                      scrollToPopOption: ScrollToPopOption.end,
                      child: VerticalScrollView(
                        scrollToPopOption: ScrollToPopOption.end,
                      ),
                    ),
                    child:
                        Text('Vertical scroll view ${ScrollToPopOption.end}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag: ScrollToPopOption.both.toString(),
                  child: ElevatedButton(
                    onPressed: () => pushOverscrollRoute(
                      context: c,
                      scrollToPopOption: ScrollToPopOption.both,
                      child: VerticalScrollView(
                        scrollToPopOption: ScrollToPopOption.both,
                      ),
                    ),
                    child:
                        Text('Vertical scroll view ${ScrollToPopOption.both}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag: '${ScrollToPopOption.start}${DragToPopDirection.toLeft}',
                  child: ElevatedButton(
                    onPressed: () => pushOverscrollRoute(
                      context: c,
                      scrollToPopOption: ScrollToPopOption.start,
                      dragToPopDirection: DragToPopDirection.toLeft,
                      child: VerticalScrollView(
                        scrollToPopOption: ScrollToPopOption.start,
                        dragToPopDirection: DragToPopDirection.toLeft,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Vertical scroll view ${ScrollToPopOption.start}'),
                          Text('${DragToPopDirection.toLeft}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag:
                      '${ScrollToPopOption.start}${DragToPopDirection.toRight}',
                  child: ElevatedButton(
                    onPressed: () => pushOverscrollRoute(
                      context: c,
                      scrollToPopOption: ScrollToPopOption.start,
                      dragToPopDirection: DragToPopDirection.toRight,
                      child: VerticalScrollView(
                        scrollToPopOption: ScrollToPopOption.start,
                        dragToPopDirection: DragToPopDirection.toRight,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Vertical scroll view ${ScrollToPopOption.start}'),
                          Text('${DragToPopDirection.toRight}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag:
                      '${ScrollToPopOption.start}${DragToPopDirection.horizontal}',
                  child: ElevatedButton(
                    onPressed: () => pushOverscrollRoute(
                      context: c,
                      scrollToPopOption: ScrollToPopOption.start,
                      dragToPopDirection: DragToPopDirection.horizontal,
                      child: VerticalScrollView(
                        scrollToPopOption: ScrollToPopOption.start,
                        dragToPopDirection: DragToPopDirection.horizontal,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Vertical scroll view ${ScrollToPopOption.start}'),
                          Text('${DragToPopDirection.horizontal}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
                ////////////////////////////////////////////////
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag: 'h ${ScrollToPopOption.start}',
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => pushPage(
                      c,
                      HorizontalScrollView(
                          scrollToPopOption: ScrollToPopOption.start),
                    ),
                    child: Text(
                        'Horizontal scroll view ${ScrollToPopOption.start}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag: 'h ${ScrollToPopOption.end}',
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => pushPage(
                      c,
                      HorizontalScrollView(
                          scrollToPopOption: ScrollToPopOption.end),
                    ),
                    child:
                        Text('Horizontal scroll view ${ScrollToPopOption.end}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag: 'h ${ScrollToPopOption.both}',
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => pushPage(
                      c,
                      HorizontalScrollView(
                          scrollToPopOption: ScrollToPopOption.both),
                    ),
                    child: Text(
                        'Horizontal scroll view ${ScrollToPopOption.both}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag: 'h ${ScrollToPopOption.end}${DragToPopDirection.toTop}',
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => pushPage(
                      c,
                      HorizontalScrollView(
                        scrollToPopOption: ScrollToPopOption.end,
                        dragToPopDirection: DragToPopDirection.toTop,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Horizontal scroll view ${ScrollToPopOption.end}'),
                          Text(DragToPopDirection.toTop.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag:
                      'h ${ScrollToPopOption.end}${DragToPopDirection.toBottom}',
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => pushPage(
                      c,
                      HorizontalScrollView(
                        scrollToPopOption: ScrollToPopOption.end,
                        dragToPopDirection: DragToPopDirection.toBottom,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Horizontal scroll view ${ScrollToPopOption.end}'),
                          Text(DragToPopDirection.toBottom.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  createRectTween: HeroAnimationAsset.customTweenRect,
                  tag:
                      'h ${ScrollToPopOption.end}${DragToPopDirection.vertical}',
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => pushPage(
                      c,
                      HorizontalScrollView(
                        scrollToPopOption: ScrollToPopOption.end,
                        dragToPopDirection: DragToPopDirection.vertical,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Horizontal scroll view ${ScrollToPopOption.end}'),
                          Text(DragToPopDirection.vertical.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(c).padding.bottom + 64.0),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.lightGreen,
            onPressed: () => pushFullScreenDragToPop(c),
            label: Text("Fullscreen drag to pop"),
          ),
        ),
      ),
    );
  }

  void pushPage(BuildContext context, Widget child) =>
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) =>
                  FadeTransition(opacity: animation, child: child),
          pageBuilder: (_, __, ___) => child,
        ),
      );

  void pushFullScreenDragToPop(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => FullScreenDragToPopExample()));
}
