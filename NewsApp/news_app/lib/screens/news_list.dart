import 'package:flutter/material.dart';
import 'package:news_app/widgets/news_list_tile.dart';
import '../blocs/stories_provider.dart';
import '../screens/news_list.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    // //bad code for temporary
    // bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    // Do you know that a Stream emits series of events not emits one by one.
    //
    return StreamBuilder(
      //list of topids which is comming from api
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              bloc.fetchItem(snapshot.data![index]);

              //Text widget always recieve a stirng
              //return Text("${snapshot.data![index]}");
              return NewsListTile(
                itemId: snapshot.data![index],
              );
            },
          ),
        );
      },
    );
  }
}

// Now there's just one little problem with that description.

// I want you to remember how a stream works and more importantly how a stream builder works.

// So we've said several times now that when we have a stream a stream is going to emit a
// series of events.

// Right.

// It's going emit a series of data events so it can kind of imagine that we might have l
//ike heres event

// number one.

// It's a future that's going to resolve with an item model and then right after it like a
//half second

// later is going to be another event that's going to be emitted like so.

// So we kind of got this like series over time of events that are being emitted from our Stream.

// Now here's the catch Here's the gotcha.

// Our stream builder right here right here and right here are watching this stream and
//it's watching for

// every data event that comes out of the stream.

// When the data event is emitted this stream right here calls its builder function with
// only only.

// Absolutely only that latest.

// Most brand new event.

// Let's imagine that we've got these three item models that we really care about and
//I'll put on here.

// Item model 1 2 and 3.

// And as you might imagine we want this one to go to ID one right here.

// We want this one to go to two and three to go to three over here.

// So maybe at some point Tonda list view that was apparent to all this stuff says oh yeah
//go fetch one

// two and three item a string controller starts doing that fetching work and then eventually
//it says OK

// I've like done the requests I've got everything lined up.

// Time to emit this stuff.

// So here's what happens.

// The stream is going to emit.

// Item number one right here stream below stream below the stream Bozer all look at that
//stream and say

// Oh fantastic it just admitted a new thing.

// I'm going to take whatever that new thing is and I'm going to check to see if it is the
// item that I

// care about.

// If it's the item that I care about I will then show that item on the screen.

// And so think about what happens here.

// This item goes to the stream builder.

// And in this case stream builder says oh it's item number one.

// Well I'm looking for ID number one.

// Fantastic.

// I'm going to rebuild myself and show this thing on the screen.

// That's great.

// But at the same time that same day the event goes over to the second which it is well now
// in this case

// stream builder looks at this item and says oh you're item number one.

// I'm looking for number two.

// Sorry but I don't really care about you.

// And so this dream builder is going to stay in some type of like loading state and it's
//going to show

// a spinner on the screen or something similar.

// And then that same event is going go over to three and a very similar thing is going to
// happen.

// This one's going to say Oh OK.

// Like sorry I don't care about you.

// I'm going to continue to show a loader and so at this point in time it kind of seems like
// everything

// is fine and good.

// Item model number one went to the correct widget.

// It's showing showing on the screen.

// But the other two are not showing anything yet.

// They're still kind of in a pending state.

// Now here's where things get crazy.

// OK.

// After some amount of time our stream is going to emit.

// Item number two stream builder stream builder stream builder all three of them.

// See this new data event the new daily event is going to be passed to all three streams.

// And there's no way that you and I can change that.

// And so item number two right here is going to go to stream builder number two.

// And here's what happens inside of this stream built right here.

// This one is looking for the one and it's already gotten it.

// It's already seen this.

// Item number one right here.

// But remember these widgets that we are working with are stateless widgets.

// And so this which is right here.

// It does not know that it already found the data event that it cares about.

// It doesn't know it has absolutely no ability to remember the fact that it already got
//the thing that

// it cares about.

// So this stream builder receives item number two right here and it says oh you know what
//I'm so I'm so

// stupid I don't even know that I got the model number one.

// Hey here's item model number two.

// Well you know what.

// I don't care about item model number two.

// So I'm going to just go back to my normal loading state because I have not gotten that
//data event that

// I care about yet.

// So that is the big issue.

// Every time this stream right here emits a new data event every one of these stream
// builders rebuilds

// with only exclusively only that new data event.

// And because these are stateless widgets they do not have the ability to say Oh well
// I already got the

// thing I care about.

// It's going to rebuild with the new data event.

// And even if it already got the thing it cares about it has no ability to remember that.

// And so this stream this which is right here is going to reset back to its initial state.

// So in short at any given time only one of these widgets right here will be showing the
// correct the thing

// on the screen.

// Think about it.

// The first event that comes out is number one.

// And so this one says Oh fantastic Heres my data.

// And so the other two were kind of blank then maybe item number 3 comes out.

// Item 3 comes out it goes to this stream builder.

// This one says great.

// Ive got something to show on the screen now but that also goes to this one and it also
//goes to this

// one.

// And so both of these widgets right here say oh this is item number three I don't care
// about that.

// I'm going to revert back to my blank state and show just like a spinner on the screen.

// What three shows the correct thing.

// But now one and two are showing the wrong thing.

// And so then finally 2 comes out two goes to all three.

// And as you might imagine now two shows the correct state but now three shows the wrong
//thing and one

// shows the wrong thing.

// All right so that's it.

// That's the big gotcha.

// And this is something that will haunt you.

// It's going to haunt you when you start using this block stuff in your own application.

// The stream builder is watching for every single event in it's going to rebuild itself
//for every single

// event and you have no ability to stop that well clearly there's got to be a work around
//here right.

// I didn't just lead us down this path for no reason.

// So yes there is a work around and it's not the worst thing in the world.

// So as you might guess take a break.

// We're going to come back in the next section.

// And we're going to talk about how we're going to fix up this entire problem.
