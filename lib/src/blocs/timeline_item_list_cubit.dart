import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/widget/timeline/timeline_post.dart';

class TimelineItemListCubit extends Cubit<List<TimelineItem>> {
  var testItem = <TimelineItem>[];

  TimelineItemListCubit({required this.testItem}) : super(testItem);

  void timelineAdder(dynamic item) {
    var expItem = <TimelineItem>[];

    expItem.addAll(item);

    emit(expItem);
  }

  void timelineItemsSort() {
    var sortedItem = <TimelineItem>[];
    sortedItem.addAll(state);

    sortedItem
        .sort((b, a) => a.feedMeta.feedDate.compareTo(b.feedMeta.feedDate));

    emit(sortedItem);
  }

  void timelineFeedRemover(String targetFeedNo) {
    var allItem = <TimelineItem>[];
    allItem.addAll(state);

    final int foundIndex =
        state.indexWhere((element) => element.feedMeta.feedNo == targetFeedNo);

    allItem.removeAt(foundIndex);

    emit(allItem);
  }

  Future<List<dynamic>> timelineItemsGetter() async {
    return state;
  }

  void timelineItemLike(
      String targetFeedNo, bool likeOrUnlike, String myUid) async {
    final int foundIndex =
        state.indexWhere((element) => element.feedMeta.feedNo == targetFeedNo);

    if (likeOrUnlike == true) {
      var items = state[foundIndex];

      items.feedMeta.likeValue = items.feedMeta.likeValue + 1;
      var item = <String>[];
      // ignore: avoid_function_literals_in_foreach_calls
      items.feedMeta.likeList.forEach((element) {
        item.add(element);
      });

      item.add(myUid);

      items.feedMeta.likeList = item;
      var allItems = state;
      allItems[foundIndex] = items;

      emit(allItems);
    } else {
      var items = state[foundIndex];
      items.feedMeta.likeValue = items.feedMeta.likeValue - 1;

      items.feedMeta.likeList.remove(myUid);

      var allItems = state;
      allItems[foundIndex] = items;
      emit(allItems);
    }
  }

  void resetItems() {
    var expItem = <TimelineItem>[];

    emit(expItem);
  }
}
