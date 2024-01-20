import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Film {
  final String title;
  final String actors;
  final String reviews;
  final String imageUrl;

  Film({
    required this.title,
    required this.actors,
    required this.reviews,
    required this.imageUrl,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Yorumlama Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilmListScreen(),
    );
  }
}

class FilmListScreen extends StatefulWidget {
  @override
  _FilmListScreenState createState() => _FilmListScreenState();
}

class _FilmListScreenState extends State<FilmListScreen> {
  List<Film> films = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Listesi'),
      ),
      body: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(films[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Oyuncular: ${films[index].actors}'),
                Text('En İyi Yorum: ${films[index].reviews}'),
              ],
            ),
            leading: Image.network(
              films[index].imageUrl,
              height: 400,
              width: 100,
              fit: BoxFit.fill,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilmDetailScreen(film: films[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Film? newFilm = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFilmScreen(),
            ),
          );

          if (newFilm != null) {
            setState(() {
              films.add(newFilm);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class FilmDetailScreen extends StatelessWidget {
  final Film film;

  FilmDetailScreen({required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Oyuncular: ${film.actors}'),
            Text('En İyi Yorum: ${film.reviews}'),
            SizedBox(height: 30),
            Image.network(film.imageUrl),
          ],
        ),
      ),
    );
  }
}

class AddFilmScreen extends StatefulWidget {
  @override
  _AddFilmScreenState createState() => _AddFilmScreenState();
}

class _AddFilmScreenState extends State<AddFilmScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController actorsController = TextEditingController();
  final TextEditingController reviewsController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Film Adı'),
            ),
            TextField(
              controller: actorsController,
              decoration:
                  InputDecoration(labelText: 'Oyuncular (Virgülle Ayırın)'),
            ),
            TextField(
              controller: reviewsController,
              decoration: InputDecoration(labelText: 'En İyi Yorum'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Resim URLsi'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String actors = actorsController.text;
                String reviews = reviewsController.text;
                String imageUrl = imageUrlController.text;

                Film newFilm = Film(
                  title: title,
                  actors: actors,
                  reviews: reviews,
                  imageUrl: imageUrl,
                );

                Navigator.pop<Film>(context, newFilm);
              },
              child: Text('Film Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
