import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends SearchDelegate {
  final String searchKey;

  Search({
    Key? key,
    required this.searchKey,
  });

  final searchResult = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query != '')
        IconButton(
          onPressed: () {
            // searchResult.clear();
            query = '';
          },
          icon: SvgPicture.asset(
            'assets/icons/cancel.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!,
              BlendMode.srcIn,
            ),
            height: 15,
          ),
        ),
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/icons/search.svg',
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color!,
            BlendMode.srcIn,
          ),
          height: 23,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: SvgPicture.asset(
        "assets/icons/arrow-left-2.2.svg",
        height: 30,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchResult.clear();
    // if (query == '') {searchResult=}

    searchResult.addAll([]);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        // controller: scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: const [],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Filtrer par',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/arrow-right-2.2.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Text(
                    'Ville / Quatier',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Wrap(spacing: 8, runSpacing: 8, children: []),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/arrow-right-2.2.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Text(
                    'Bail',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [],
              ),
              const SizedBox(
                height: 20.0,
              ),
              // Text('Recent search')
            ],
          ),
        ),
      ),
    );
  }

  Widget postBuilder({
    required BuildContext context,
    required home,
  }) {
    return const Placeholder();
  }
}
