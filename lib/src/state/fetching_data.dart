import 'package:fitness_time/src/service/paged_response.dart';

class PageFetchingData<T> {
  List<T> data = [];
  int lastFetchedPage = 0;
  int totalElements = 0;
  int size = 0;

  void updateData(PagedResponse<T> pagedResponse) {
    data.addAll(pagedResponse.content);
    lastFetchedPage = pagedResponse.current;
    totalElements = pagedResponse.total;
    size = pagedResponse.totalPages;
  }

  void reset() {
    data.clear();
    lastFetchedPage = 0;
  }
}
