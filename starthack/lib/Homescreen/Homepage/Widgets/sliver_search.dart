import 'package:flutter/material.dart';

import '../../Declarations/constants.dart';

class SliverSearch extends StatelessWidget {
  const SliverSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      pinned: true,
      bottom: const PreferredSize(preferredSize: Size.fromHeight(0.0), child: SizedBox()),
      flexibleSpace: const SearchBar(),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 110, 40, 249),
            child: Container(
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 247, 247),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Stack(
              children: [
                Container(
                  child: Image.asset("assets/images/SearchButton.png"),
                  //padding: EdgeInsets.only(left: 268.0),
                  alignment: Alignment.centerRight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: 'Search for Stocks...',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
