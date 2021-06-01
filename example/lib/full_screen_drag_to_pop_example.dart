import 'package:flutter/material.dart';

import 'package:overscroll_pop/overscroll_pop.dart';
import 'package:overscroll_pop_example/hero_animation_asset.dart';

class FullScreenDragToPopExample extends StatelessWidget {
  final images = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
    "https://images.adsttc.com/media/images/5b08/b87c/f197/ccb5/4900/00bd/medium_jpg/The_S_02_filter_edit2_06.jpg?1527298139",
    "https://images.unsplash.com/photo-1526512340740-9217d0159da9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dmVydGljYWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
    "https://mobirise.com/bootstrap-carousel/assets2/images/thomas-smith-399133-1707x2560.jpg",
    "https://inteng-storage.s3.amazonaws.com/img/iea/9lwj5pMV6E/sizes/vertical-forests-1_resize_md.jpg",
    "https://thumbs.dreamstime.com/b/group-young-people-having-fun-drinking-smoothies-vertical-group-young-people-having-fun-drinking-smoothies-191682012.jpg",
    "https://vcdn-english.vnecdn.net/2020/09/08/6286-2-6995-1596186843-2395-1599554020.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drag To Pop Example")),
      body: GridView.builder(
        itemCount: images.length,
        padding: const EdgeInsets.all(1.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemBuilder: (_, int index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 250),
              reverseTransitionDuration: const Duration(milliseconds: 250),
              fullscreenDialog: true,
              opaque: false,
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) =>
                      FadeTransition(opacity: animation, child: child),
              pageBuilder: (_, __, ___) => FullScreenDetail(url: images[index]),
            ),
          ),
          child: Hero(
            tag: images[index],
            createRectTween: HeroAnimationAsset.customTweenRect,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class FullScreenDetail extends StatelessWidget {
  final String url;

  const FullScreenDetail({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragToPop(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Center(
            child: Hero(
              tag: url,
              createRectTween: HeroAnimationAsset.customTweenRect,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
