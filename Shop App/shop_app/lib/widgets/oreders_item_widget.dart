import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/orders.dart';
//for date formating
import 'package:intl/intl.dart';

class OrdersItemWidget extends StatefulWidget {
  final OrderItem? order;

  OrdersItemWidget(this.order);

  @override
  State<OrdersItemWidget> createState() => _OrdersItemWidgetState();
}

class _OrdersItemWidgetState extends State<OrdersItemWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order!.amount}"),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order!.dateTime!),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              padding: EdgeInsets.all(10),
              height: max(widget.order!.products!.length * 25 + 50, 70),
              child: ListView(
                children: widget.order!.products!
                    .map(
                      (pro) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              pro.title!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '${pro.quantity} x \$${pro.price}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
