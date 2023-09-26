typedef ContentParser<T> = T Function(dynamic);

class PagedResponse<T> {
  final List<T> content;
  final int current;
  final int totalPages;
  final int total;

  PagedResponse({
    this.content,
    this.current,
    this.totalPages,
    this.total,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    ContentParser contentParser,
  ) {
    final List list = json['content'];

    return PagedResponse(
      content: list
          .map(
            (dynamic e) => (contentParser(e) as T),
          )
          .toList(),
      current: json['current'],
      totalPages: json['totalPages'],
      total: json['total'],
    );
  }
}
