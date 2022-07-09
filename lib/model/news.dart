class News {
  late String title;
  late String author;
  late String published_date;
  late String link;
  late String summary;
  late String media;

  News({
    required this.title,
    required this.author,
    required this.published_date,
    required this.link,
    required this.summary,
    required this.media,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        title: json['title'] ?? '',
        author: json['author'] ?? '',
        published_date: json['published_date'] ?? '',
        link: json['link'] ?? '',
        summary: json['summary'] ?? '',
        media: json['media'] ?? '');
  }
}
