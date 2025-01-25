import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/data/repositories/feed_repository.dart';
import 'package:test_task/presentation/blocs/main/main_bloc.dart';

import '../../../data/models/user.dart';
import '../../widgets/feed_photo_list.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('List Page')),
        actions: [IconButton(onPressed: null, icon: Icon(Icons.search))],
      ),
      drawer: _MainPageDrawer(user: user),
      body: BlocProvider<MainBloc>(
        create: (context) => MainBloc(
          feedRepository: context.read<FeedRepository>(),
        ),
        child: _MainPageLayout(),
      ),
    );
  }
}

class _MainPageDrawer extends StatelessWidget {
  const _MainPageDrawer({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 25.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 4),
                        Text(
                          user.email,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<MainBloc>().add(MainFetchFeedRequested());

    return SafeArea(
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return switch (state.status) {
            MainStatus.loading => Center(child: CircularProgressIndicator()),
            // TODO: add refresh button to Centers
            MainStatus.error => Center(child: Text('An error occurred!')),
            MainStatus.empty => Center(child: Text('No content available :(')),
            MainStatus.data => RefreshIndicator(
                onRefresh: () async {
                  Future block = context.read<MainBloc>().stream.first;
                  context.read<MainBloc>().add(MainFetchFeedRequested());
                  await block;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FeedPhotoList(photos: state.photos),
                ),
              ),
          };
        },
      ),
    );
  }
}
