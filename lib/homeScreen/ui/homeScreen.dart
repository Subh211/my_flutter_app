import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_bloc.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_event.dart';
import 'package:my_flutter_app/homeScreen/bloc/homeScreen_state.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(FetchNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    String searchText = _searchController.text.trim();
                    context.read<NewsBloc>().add(SearchNews(searchTerm: searchText));
                  },
                  icon: Icon(Icons.search, color: Colors.blue),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search in feed',
                      hintStyle: TextStyle(color: Colors.blue),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                    // Navigate to login or home screen after logout
                  },
                  icon: Icon(Icons.logout, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            return Center(child: Text('Please wait while news is being fetched...'));
          } else if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return NewsCard(
                  title: article['title'] ?? 'No Title',
                  description: article['description'] ?? 'No Description',
                  publishedAt: article['publishedAt'] ?? 'No Date',
                  source: article['source']['name'] ?? 'No Source',
                  imageUrl: article['urlToImage'] ?? '',
                );
              },
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}



class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String publishedAt;
  final String source;
  final String imageUrl;

  NewsCard({
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.source,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          publishedAt,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          source,
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width * 0.30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error);
                  },
                )
                    : Icon(Icons.image_not_supported),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
