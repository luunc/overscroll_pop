import 'package:flutter/material.dart';
import 'package:overscroll_pop/overscroll_pop.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Overscroll Example'),
        ),
        body: Builder(
          builder: (c) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(c).size.width,
                  height: 32.0,
                ),
                Hero(
                  tag: ScrollToPopOption.start.toString(),
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => VerticalScrollview(
                        scrollToPopOption: ScrollToPopOption.start,
                      ),
                    ),
                    child:
                        Text('Vertical scrollview ${ScrollToPopOption.start}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag: ScrollToPopOption.end.toString(),
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => VerticalScrollview(
                        scrollToPopOption: ScrollToPopOption.end,
                      ),
                    ),
                    child: Text('Vertical scrollview ${ScrollToPopOption.end}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag: ScrollToPopOption.both.toString(),
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => VerticalScrollview(
                        scrollToPopOption: ScrollToPopOption.both,
                      ),
                    ),
                    child:
                        Text('Vertical scrollview ${ScrollToPopOption.both}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag: '${ScrollToPopOption.start}${DragToPopDirection.toLeft}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => VerticalScrollview(
                        scrollToPopOption: ScrollToPopOption.start,
                        dragToPopDirection: DragToPopDirection.toLeft,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Vertical scrollview ${ScrollToPopOption.start}'),
                          Text('${DragToPopDirection.toLeft}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag:
                      '${ScrollToPopOption.start}${DragToPopDirection.toRight}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => VerticalScrollview(
                        scrollToPopOption: ScrollToPopOption.start,
                        dragToPopDirection: DragToPopDirection.toRight,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Vertical scrollview ${ScrollToPopOption.start}'),
                          Text('${DragToPopDirection.toRight}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag:
                      '${ScrollToPopOption.start}${DragToPopDirection.horizontal}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => VerticalScrollview(
                        scrollToPopOption: ScrollToPopOption.start,
                        dragToPopDirection: DragToPopDirection.horizontal,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Vertical scrollview ${ScrollToPopOption.start}'),
                          Text('${DragToPopDirection.horizontal}'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag: 'h ${ScrollToPopOption.start}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => HorizontalScrollview(
                        scrollToPopOption: ScrollToPopOption.start,
                      ),
                    ),
                    child: Text(
                        'Horizontal scrollview ${ScrollToPopOption.start}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag: 'h ${ScrollToPopOption.end}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => HorizontalScrollview(
                        scrollToPopOption: ScrollToPopOption.end,
                      ),
                    ),
                    child:
                        Text('Horizontal scrollview ${ScrollToPopOption.end}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag: 'h ${ScrollToPopOption.both}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => HorizontalScrollview(
                        scrollToPopOption: ScrollToPopOption.both,
                      ),
                    ),
                    child:
                        Text('Horizontal scrollview ${ScrollToPopOption.both}'),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag: 'h ${ScrollToPopOption.end}${DragToPopDirection.toTop}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => HorizontalScrollview(
                        scrollToPopOption: ScrollToPopOption.end,
                        dragToPopDirection: DragToPopDirection.toTop,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Horizontal scrollview ${ScrollToPopOption.end}'),
                          Text(DragToPopDirection.toTop.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag:
                      'h ${ScrollToPopOption.end}${DragToPopDirection.toBottom}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => HorizontalScrollview(
                        scrollToPopOption: ScrollToPopOption.end,
                        dragToPopDirection: DragToPopDirection.toBottom,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Horizontal scrollview ${ScrollToPopOption.end}'),
                          Text(DragToPopDirection.toBottom.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Hero(
                  tag:
                      'h ${ScrollToPopOption.end}${DragToPopDirection.vertical}',
                  child: ElevatedButton(
                    onPressed: () => pushPage(
                      c,
                      (BuildContext context, _, __) => HorizontalScrollview(
                        scrollToPopOption: ScrollToPopOption.end,
                        dragToPopDirection: DragToPopDirection.vertical,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Horizontal scrollview ${ScrollToPopOption.end}'),
                          Text(DragToPopDirection.vertical.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(c).padding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pushPage(BuildContext context, RoutePageBuilder builder) =>
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) =>
                  FadeTransition(opacity: animation, child: child),
          pageBuilder: builder,
        ),
      );
}
