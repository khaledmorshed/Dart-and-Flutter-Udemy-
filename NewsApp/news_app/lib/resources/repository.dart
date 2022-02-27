import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

//  actually it works as a parent of NewsApiProvider and NewsDbProvider. When our
//  app is opened then at first data will search from NewsDbProvider it not found
//  the it will call NewsApiProvider
class Repository {
  // NewsDbProvider dbProvider = NewsDbProvider();
  // NewsApiProvider apiProvider = NewsApiProvider();

  //to connect any number of class with Repository class, we are taking List of Source abstract
  //class
  List<Source> sources = <Source>[
    //(i)here first is called NewsDbProvider
    //NewsDbProvider(),
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    //(i)here second time is called NewsDbProvider. two times calling NewsDbProvider will call
    //openDatabase two times, that is not good.so isntead that call by reference of NewsDbProvider
    //named newsDbProvider. And now one instance has been created
    //NewsDbProvider(),
    newsDbProvider,
  ];

//async and await is added
  Future<List<int>> fetchTopIds() {
    //return apiProvider.fetchTopIds();
    return sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    //(ii)
    // var item = await dbProvider.fetchItem(id);
    // if (item != null) {
    //   return item;
    // }
    // //new Item has come.so need to add in database
    // item = await apiProvider.fetchItem(id);
    // dbProvider.addItem(item);
    // return item;

    //(ii) instead of above code bellow is perfect
    ItemModel? item;
    var source;

    //it will fetchItem from NewsDbProvider or NewsApiProvider.it will fetch
    //where it is in List of Source
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    //it will add item in database as a cache
    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item!);
      }
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      //this clear is from Cache class which is abstract in bellow.
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
