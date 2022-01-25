void main() {
  var VariableDeck = new Deck();
 // print("$VariableDeck" + "\n\n"); // prited origin list
  VariableDeck.shuffle();
  //print(VariableDeck); // printed shuffle list
 // print("\n\n");
  print(VariableDeck.cardsWithSuit('Hearts'));// printed all rank of Diamond suit
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

    for (var suit in suits) {
      for (var rank in ranks) {
        var variableCard = Card(rank, suit);
        listCards?.add(variableCard);
      }
    }
  }

  toString() {
    // it is built in function not a general method . if we call it then it gives us its result.it actually represent it own class such as here is Deck.
    return listCards
        .toString(); // it return instance of Card class.it means list of instance of Card class when we do not use toString function in Card.
    // But when we use toString function in Card class then it will return the
    // value of Card class property like rank and suit.
  }

  shuffle() {
    // To create randome the list
    listCards!.shuffle();
  }

  //(i) cardsWithSuit(String suit) {
  //   return listCards?.where((card) {
  //     return card.suit == suit;
  //   });
  // }
  
  // this syntax is as same as above (i)
  cardsWithSuit(String suit) {
    return listCards?.where((card) => card.suit == suit);
  }

}

class Card {
  String? suit;
  String? rank;

  // Card(ra, su) {
  //   this.suit = ra;
  //   this.rank = su;
  // }
  Card(this.rank, this.suit);

  toString() {
    return '$rank of $suit';
  }
}
