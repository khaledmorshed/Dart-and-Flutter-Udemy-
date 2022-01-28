void main() {
  var VariableDeck = new Deck();
  print(VariableDeck);// printed original list
  print("\n\n");
  print(VariableDeck.deal(13));// printed 13 elements of diamonds 
   print("\n\n");
  print(VariableDeck);// printed rest of the elements except diamonds' elements
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
    return listCards.toString();
  }

  cardsWithSuit(String suit) {
    return listCards?.where((card) => card.suit == suit);
  }

  // sublist is to cut and store some elements from original list
  deal(int handSize) {
    var hand = listCards!.sublist(0, handSize);
    listCards = listCards!.sublist(handSize);
    return hand;
  }
}

class Card {
  String? suit;
  String? rank;

  Card(this.rank, this.suit);

  toString() {
    return '$rank of $suit';
  }
}
