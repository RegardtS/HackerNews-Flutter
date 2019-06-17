import 'package:flutter/material.dart';
import 'package:news/src/screens/news_detail.dart';
import 'package:news/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      if (settings.name == '/') {

        final storiesBloc = StoriesProvider.of(context);
        storiesBloc.fetchTopIds();

        return NewsList();
      } else {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/', ''));

        commentsBloc.fetchItemWithComments(itemId);

        return NewsDetails(itemId);
      }
    });
  }
}
