String getYouTubeThumbnail(String url) {
  // Regular expression to extract the video ID from the URL
  final RegExp regExp = RegExp(
    r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})'
  );

  final match = regExp.firstMatch(url);
  if (match != null && match.groupCount >= 1) {
    final videoId = match.group(1);
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg'; // High-quality thumbnail
  }
  return ''; // Return an empty string if the URL is invalid
}