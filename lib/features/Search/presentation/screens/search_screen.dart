import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/widgets/search_rooms_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/text_editing_controllers.dart';
import '../bloc/search_bloc.dart';
import '../widgets/search_app_bar_widget.dart';
import '../widgets/search_text_field_widget.dart';
import '../widgets/users_search_widget.dart';

late TabController searchTabController;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initController();
    searchTabController = TabController(length: 3, vsync: this);
    initSearchListener();
  }

  @override
  void dispose() {
    disposeController();
    searchTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.175,
                    child: Column(
                      children: const [
                        SearchTextFieldWidget(),
                        SearchAppBarWidget(),
                      ],
                    ),
                  ),
                ),
              ],
          body: TabBarView(
            controller: searchTabController,
            children: [
              const UsersSearchWidget(),
              const RoomsSearchWidget(),
              Container(
                color: Colors.blue,
              ),
            ],
          )),
    );
  }

  void initSearchListener() {
    TextEditingControllers.searchController.addListener(() {
      if (TextEditingControllers.searchController.text.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1), () {
          switch (searchTabController.index) {
            case 0:
              BlocProvider.of<SearchBloc>(context).add(UsersSearchEvent(
                  accessToken: ConstVar.accessToken,
                  query: TextEditingControllers.searchController.text));
              break;
            case 1:
              BlocProvider.of<SearchBloc>(context).add(RoomsSearchEvent(
                  accessToken: ConstVar.accessToken,
                  query: TextEditingControllers.searchController.text));
              break;
            case 2:
              BlocProvider.of<SearchBloc>(context).add(PodcastSearchEvent(
                  accessToken: ConstVar.accessToken,
                  query: TextEditingControllers.searchController.text));
              break;
          }
        });
      }
    });
  }

  void initController() {
    TextEditingControllers.searchController = TextEditingController();
  }

  void disposeController() {
    TextEditingControllers.searchController.dispose();
  }
}
