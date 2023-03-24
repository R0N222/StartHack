import 'package:flutter/material.dart';

class SliverAppBarBldr extends StatelessWidget {
  const SliverAppBarBldr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color.fromARGB(255, 110, 40, 249),
      elevation: 0,
      pinned: true,
      centerTitle: false,
      stretch: true,
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        background: Container(
          color: Color.fromARGB(255, 110, 40, 249),
          child: Image(
            image: AssetImage('assets/images/HeroPicture.png'),
            fit: BoxFit.cover,
          ),
        ),
        /*Image(
          
          image: AssetImage('assets/images/banner.jpg'),
          fit: BoxFit.cover,
        ),*/
      ),
    );
  }
}
