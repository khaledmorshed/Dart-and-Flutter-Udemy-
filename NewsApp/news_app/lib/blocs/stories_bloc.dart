import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import 'package:news_app/resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();

  //PublishSubject is similar to normal StreamController.But it returns an Rx(Observable)
  //insteda of a Stream
  final _topIds = PublishSubject<List<int>>();
  //int == item number may be
  //final _item = BehaviorSubject<int>();

  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemsFetcher = PublishSubject<int>();

  //global variable
  //Stream<Map<int, Future<ItemModel?>>>? items;

  //getter is setted istead of items variable
  Stream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;

  //getter to stream
  //Stream is instead of Observable
  //Do you know that a Stream emits series of events not emits one by one.
  Stream<List<int>> get topIds => _topIds.stream;

  /*Dont write this code.just for understanding. it is gotcha. because we want to call
  _itemsTransfomer only one time.
  get _item => _item.stream.transform(_itemsTransformer());
  */

  //Getter to sink
  //Function(int) get fetchItem => _item.sink.add;

  //_itemsFetcher.sink.add = it just fetch the item id
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  //constructor.._itemsTransformer will be invoked only one time beacuse it is under of constructor
  //and this is caught by a Stream map items variable
  //item.stream.transform == this stream not update our original Stream. it just return a Stream
  //. thats why a items variable
  StoriesBloc() {
    //items = _item.stream.transform(_itemsTransformer());

    // pipe function is pretty straightforward.It takes every output event from that stream and it
    // automatically forwards it on to some target destination.
    //so here _itemsFetcher brings item id and pass it transformer and this transformer
    //output(Map<int, Future<ItemModel>>) goes to _itemsOutput as input and this _itemsOutput
    // return Map<int, Future<ItemModel?>> as an output
    //pipe recieves output from _itemsFetcher.stream.transform(_itemsTransformer()) and pass this
    //output _itemsOutput
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  //istead of getter we are creating a function.Because this funciton will not be called
  //any widget.it will be called from Repository class to get topIds
  fetchTopIds() async {
    //this _repository.fetchTopIds() is the fucntion of Repository class.
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    //return a future
    return _repository.clearCache();
  }

  _itemsTransformer() {
    //it takes list of event from Stream and pass to StreamBuilder.And StreamBuilder rebuild only
    //with specific id.it doesnt take wrong id.
    return ScanStreamTransformer(
      //this a function it will invok when data will come in ScanStreamTransformer
      //cache = this is object. inside of this id and item stay. cache one type of map
      //index = it is the integer number that represent how many times ScanStreamTransformer
      //actually invoked. "index" == "_"
      //so here int id catch the apropraite id
      // and _repository.fetchItem(id) = fetch the item freo
      (Map<int, Future<ItemModel?>> cache, int id /*it is topid*/, index) {
        //print("$index");
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      //empty map. it is initial value of ScanStreamTransformer
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _topIds.close();
    //_item.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
