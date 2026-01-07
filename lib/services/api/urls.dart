const String _API_KEY = 'NEWS_API_KEY';

class Urls{
  static const String baseUrl = 'http://newsapi.org/v2';
  static const String headLines = '/top-headlines?excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=$_API_KEY';
}