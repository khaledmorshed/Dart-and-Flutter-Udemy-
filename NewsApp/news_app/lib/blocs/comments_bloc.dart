import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item_model.dart';
import 'dart:async';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();

  //streams getter
  //itemWithComments here it represents as a collection of comments
  Stream<Map<int, Future<ItemModel?>>> get itemWithComments =>
      _commentsOutput.stream;

  //sink getter
  //fetchItemWithComments it recieves values of type integer
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }
  _commentsTransformer() {
    //for antoher way instead of ScanStreamTransformer.just for guessing
    // StreamTransformer.fromHandlers(
    //   handleData: (){}
    // );

    //ScanStreamTransformer maintains internal cache also
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
      //recursively data fetchig inside of this fucntion when an event comes into _commentsTransformer
      //int id = from commentsFether which was initially fetched in storiesbloc
      (cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        //inside of cache[id] ItemModel item is present with particluar id
        cache[id]!.then(
          (ItemModel? item) {
            //here item access kids(from ItemModel class) and iterate this kids with for loop
            item!.kids!.forEach((kidId) => fetchItemWithComments(kidId));
            // for (var kidId in item!.kids) {
            //   fetchItemWithComments(kidId);
            // }
          },
        );
        return cache;
      },
      //an empty map which serve as our cache
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
