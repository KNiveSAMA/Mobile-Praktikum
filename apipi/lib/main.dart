import 'package:flutter/material.dart';
import 'package:apipi/api_service.dart';
import 'package:apipi/article_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita',
      debugShowCheckedModeBanner: false,
      home: const NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>> _articlesFuture;
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiService().fetchArticles();

    _scrollController.addListener(() {
      final show = _scrollController.offset > 300;
      // setState hanya dipanggil kalau nilainya berubah (hemat rebuild)
      if (show != _showButton) {
        setState(() => _showButton = show);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Pull-to-refresh
  Future<void> _refresh() async {
    final newArticles = ApiService().fetchArticles();
    try {
      await newArticles;
    } catch (_) {}
    if (!mounted) return;
    setState(() => _articlesFuture = newArticles);
  }

  // Kembali ke atas
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Aplikasi Berita'),
      ),
      body: FutureBuilder(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error :${snapshot.error}'));
          } else if (snapshot.hasData) {
            final articles = snapshot.data!;
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    child: ListTile(
                      leading: article.urlToImage != null
                          ? Image.network(
                              article.urlToImage!,
                              width: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  const Icon(Icons.broken_image),
                            )
                          : const Icon(Icons.image),
                      title: Text(article.title),
                      subtitle:
                          Text(article.description ?? 'Tidak ada deskripsi'),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('Tidak ada berita'));
          }
        },
      ),
      floatingActionButton: _showButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}