# overscroll_pop

A Flutter widget for Scrollview, pop when overscroll like Instagram, Pinterest, ...


![Demo](https://media.giphy.com/media/lL2VFks4VVMNlfuwP0/giphy.gif) ![Demo](https://media.giphy.com/media/djg5Hc5b3ArVgb0pCP/giphy.gif) ![Demo](https://media.giphy.com/media/suIR06ewXDsrwWFszb/giphy.gif)

## Getting Started

1) Include the package to your project as dependency:

```
dependencies:
  	overscroll_pop: <latest version>
```


2) Use the widget:

Wrap your `Scaffold` or top widget by `OverscrollPop`, every `ScrollView` widget (`Listview`, `GridView`, `PageView`, `CustomScrollView`, ...) which has scroll physics `ClampingScrollPhysics`**(important)** will have overscroll to pop effect.

```dart
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Overscroll Example'),
        ),
        body: Builder(
          builder: (c) => Center(
            child: Hero(
              tag: '${ScrollToPopOption.start}${DragToPopDirection.toRight}',
              child: ElevatedButton(
                onPressed: () => pushPage(
                  c,
                  (BuildContext context, _, __) => VerticalScrollview(
                    scrollToPopOption: ScrollToPopOption.start,
                    dragToPopDirection: DragToPopDirection.toRight,
                  ),
                ),
                child: Text('Vertical scrollview ${ScrollToPopOption.start}'),
              ),
            ),
          ),
        ),
      ),
    );

    class VerticalScrollview extends StatelessWidget {
      final ScrollToPopOption scrollToPopOption;
      final DragToPopDirection? dragToPopDirection;

      const VerticalScrollview({
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
                  tag: '$scrollToPopOption${dragToPopDirection ?? ''}',
                  child: AppBar(
                    title: Text(
                      'Vertical Scrollview',
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
              body: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemBuilder: (_, index) => Container(
                  height: 160.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: index % 2 == 0 ? Colors.cyanAccent : Colors.orangeAccent,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(scrollToPopOption.toString()),
                      if (dragToPopDirection != null)
                        Text(dragToPopDirection.toString()),
                    ],
                  ),
                ),
                itemCount: MediaQuery.of(context).size.height ~/ 160.0 + 2,
              ),
            ),
          ),
        );
      }
    }
```

If your `Scaffold` does not contain any ScrollView and want to achieve drag to pop effect, wrap your `Scaffold` or top widget by `DragToPop` instead [(Example)](https://github.com/luunc/overscroll_pop/blob/main/example/lib/full_screen_drag_to_pop_example.dart).

Quick push route config helper:
```
pushOverscrollRoute(
    context: context,
    child: <your scaffold/widget>,
    // scrollToPopOption: <your ScrollToPopOption>,
    // dragToPopDirection: <your DragToPopDirection>,
    // other route configs
)

pushDragToPopRoute(
    context: context,
    child: <your scaffold/widget>,
    // other route configs
)
```


3) Configure scroll direction and add extra drag to pop:
    - By default, the effect only apply for overscroll at the start of `ScrollView` (top edge of vertical scroll, left edge of horizontal scroll)

        ![VStart](https://media.giphy.com/media/lL2VFks4VVMNlfuwP0/giphy.gif) ![HStart](https://media.giphy.com/media/p27QKg0HJnutxKcsjV/giphy.gif)

    - To enable the end edge (or both edges) for overscroll to pop, set `scrollToPopOption` to `ScrollToPopOption.end` (or `ScrollToPopOption.both`)
        ```
        OverscrollPop(
          scrollToPopOption: ScrollToPopOption.end, // or ScrollToPopOption.both
          ...
        )
        ```
        ![VEnd](https://media.giphy.com/media/8fHrG757aaUlhwrODA/giphy.gif) ![HEnd](https://media.giphy.com/media/X81NGib9XPZU3o7oek/giphy.gif)

    - Beside overscroll, you can config the other drag direction to achieve the pop effect by passing `dragToPopDirection`
        ```
        OverscrollPop(
          dragToPopDirection: DragToPopDirection.toTop, //  toTop, toBottom, toLeft, toRight, horizontal and vertical
          ...
        )
        ```

        1. Vertical scroll: drag to left, right or horizontal (both left and right)
            ![VStartToLeft](https://media.giphy.com/media/jfgkDuYpxeVwXiyDWX/giphy.gif) ![VStartToLeft](https://media.giphy.com/media/1vB9UWq9okIuSYHcNd/giphy.gif)

        2. Horizontal scroll: drag to top, bottom or vertical (both top and bottom)
            ![HEndToTop](https://media.giphy.com/media/qoScSSBnAX0MEe4R51/giphy.gif) ![HEndToBottom](https://media.giphy.com/media/hN3KTJlvqoEdMaFnIV/giphy.gif)