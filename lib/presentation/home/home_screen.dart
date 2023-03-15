import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search/common/layout/default_layout.dart';
import 'package:image_search/presentation/component/widget/photo_widget.dart';
import 'package:image_search/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<HomeViewModel>();
      _subscription = viewModel.eventStream.listen((event) {
        event.when(showSnackBar: (String e) {
          final snackBar = SnackBar(content: Text(e));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final homeState = viewModel.homeState;

    return DefaultLayout(
      title: "이미지 검색 앱",
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    final text = _controller.text;
                    viewModel.fetch(text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          homeState.isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: homeState.photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final photo = homeState.photos[index];
                      return PhotoWidget(
                        photo: photo,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
