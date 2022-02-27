import 'package:news_app/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
//it gives access to store data in folder or directoroy in our mobile device
import 'package:path_provider/path_provider.dart';
//working with file system = Directory
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'dart:async';

// //(i)
final newsDbProvider = NewsDbProvider();

class NewsDbProvider implements Source, Cache {
  //Database is comming from sqflite database.its represents connetion of database that is stored on
  //our physical device
  Database? db;

  //first we want to call init. but when we create an instance of NewsDbProvider at bellow(i)
  //then it will never call init method.why? I don't know.
  NewsDbProvider() {
    init();
  }

  //it is from repository class. And may be Source
  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    throw UnimplementedError();

    //  List<int> list = await fetchTopIds();
    //  return list;
  }

  //it is from repository class. And may be Source
  @override
  Future<ItemModel?> fethcItem(int id) {
    // TODO: implement fethcItem
    throw UnimplementedError();

    // ItemModel? n = await fetchItem(id);
    //  return n;
  }

  //for initial database setup
  //it acually instead of NewsDbProvider constructor. In constructor we can not use async.
  //for this reason we had to make a init function
  //when we call intit function then we are gonig to write some code where database will create or
  //database will reopen
  void init() async {
    //getApplicationDocumentsDirectory = it returns a reference to a folder on our mobile device where
    //we can safely somewhat permanently store differents file
    //documentDirectory = it just a folder reference.
    Directory documentDirectory =
        await getApplicationDocumentsDirectory(); //(reference to directory)
    //here we join these two strings together like we join documentDirectory the path and the word
    //items.db
    //Finaly path vairable store the reference to the actual file path where we create our database.
    final path =
        join(documentDirectory.path, "items.db"); //(reference to database)

    //(i)openDatabase = it open the database that already exists at the given path or if there is no
    //database at this path then its going to create a new database for us.
    db = await openDatabase(
        //(i) = (for understanding) it open the database that already exists at the given path or
        //if there is no database at this path then its going to create a new database for us.
        path,
        //if we change database or shcema then it will increment and it makes scense what state database
        //is in now
        version: 1,
        //it create inital table for database when very first time the user install the aplication
        onCreate: (Database newDb, int version) {
      //BLOB = it is kind of a big set of data that we can store anything inside of it
      //that we want
      //sqflite = it doesn't have true or false function. it know stirngs and integer.
      //instead of true and false it use 1 and 0
      newDb.execute("""
            CREATE TABLE Items(
              id  INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              dead INTEGER,
              deleted INTEGER,
              parent INTEGER,
              kids BLOB,
              url TEXT,
              score INTEGER,
              title TEXT, 
              descendants INTEGER                      
            )
        """);
    });
  }

  //For query into database
  //it takes an id and return an individual item of that id
  Future<ItemModel?> fetchItem(int id) async {
    //we will query in Item table
    //so when we will query upon a table then it return list of map
    final maps = await db!.query(
      "Items",
      //columns: ["title"] = this will query only the title column but we need
      //all column of a specific id. so bellow is the right code
      columns: null,
      //where clause = this query clause is specifying the acutal search criteria the we use
      //when we issue this query over to our database. if we give id = 1 then ? will be fill up.
      //And means we want to query upon 1.
      where: "id = ?",
      //list of argument that we will pass
      whereArgs: [id],
    );

    //if list of map has at least one item.And may be it just for first map
    //And fetchItem function may query onlu for first item.don't sure
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  //inset data inoto database
  //async not requered because it just insert data into table
  Future<int> addItem(ItemModel? item) {
    /*here item is conveted into a map when toMap is called with the item*/
    return db!.insert(
      "Items", item!.toMap(),
      //if an id already exist in database then this ConflictAlgorithm class inside of name
      // parameter named conflictAlgorithm will ignore that id. ConflictAlgorithm comes from
      //sqlflite package
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  //delete all cache data of table in database
  Future<int> clear() {
    return db!.delete("Items");
  }
}
