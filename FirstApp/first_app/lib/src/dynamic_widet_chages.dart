import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyList(),
    );
  }
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<bool> _isExpandedList = List.generate(5, (index) => false);

  void updateExpansionState(int index, bool isExpanded) {
    _isExpandedList[index] = isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    print("build....................main");
    return Scaffold(
      appBar: AppBar(
        title: Text('Expandable List'),
      ),
      body: ListView.builder(
        itemCount: _isExpandedList.length,
        itemBuilder: (context, index) {
          return ExpandableTextItem(
            text: 'Item $index',
            isExpanded: _isExpandedList[index],
            onExpansionChanged: (isExpanded) {
              updateExpansionState(index, isExpanded);
            },
          );
        },
      ),
    );
  }
}

class ExpandableTextItem extends StatefulWidget {
  final String text;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  ExpandableTextItem({
    required this.text,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  _ExpandableTextItemState createState() => _ExpandableTextItemState();
}

class _ExpandableTextItemState extends State<ExpandableTextItem> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        widget.onExpansionChanged(_isExpanded); // Notify parent of the change
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'This is item ${widget.text}',
                style: TextStyle(fontSize: 14),
              ),
            ),
          Divider(),
        ],
      ),
    );
  }
}
