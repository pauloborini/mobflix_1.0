
String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();

  for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match? match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }
  return null;
}

final Map<String, int> categoryMap = {
  'Ação': -14049492,
  'Terror': -2350542,
  'Suspense': -16777216,
  'Aventura': -13251864,
  'Ficção Científica': -14049492,
  'Animação': -13251864,
  'Drama': -14583081,
  'Comédia': -13251864,
  'Médicas': -14049492,
  'Romance': -2350542,
  'Fantasia': -14583081,
  'Espionagem': -3695864,
  'Musical': -16777216,
  'Policial': -3695864,
  'Guerra': -13251864,
};

