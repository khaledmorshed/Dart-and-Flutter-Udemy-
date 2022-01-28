void main() {
  var VariableDeck = new Deck();
  print(VariableDeck);
  print("\n\n");
  VariableDeck.removeCard(
      'Diamonds', 'two'); // two of Diamonds is deleted from the listCards
  print(VariableDeck);
}

class Deck {
  List<Card>? listCards = [];

  Deck() {
    var ranks = [
      'Ace',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten',
      'jack',
      'quen',
      'king'
    ];

    var suits = ['Diamonds', 'Hearts', 'Clubs', 'Spades'];

    //(i) for (var suit in suits) {
    //   for (var rank in ranks) {
    //     var variableCard = Card(rank, suit);
    //     listCards?.add(variableCard);
    //   }
    // }

    for (var mySuit in suits) {
      for (var rank in ranks) {
        var variableCard = Card(
          rank: rank,
          suit: mySuit,
        );
        listCards?.add(variableCard);
      }
    }
  }

  toString() {
    return listCards.toString();
  }

  cardsWithSuit(String suit) {
    return listCards?.where((card) => card.suit == suit);
  }

  removeCard(String suit, String rank) {
    listCards?.removeWhere((card) {
      return card.suit == suit && card.rank == rank;
    });
  }
}

class Card {
  String? suit;
  String? rank;

  //Card(this.rank, this.suit);// this constructor for (i)

  Card({this.rank, this.suit});

  toString() {
    return '$rank of $suit';
  }
}
