import 'package:agriculture/data/product.dart';
import 'package:agriculture/models/order.dart';
import 'package:agriculture/models/product.dart';
import 'package:agriculture/pages/farmer_info_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage(
      {super.key, required this.order, required this.product});

  final Product product;
  final Order order;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool showingMore = false;
  late TapGestureRecognizer readMoreGestureRecognizer;
  double _rating = 0; // Default star rating
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget _buildStar(int index) {
    if (index < _rating) {
      return IconButton(
        onPressed: () {
          setState(() {
            _rating = index + 1;
          });
        },
        icon: Icon(Icons.star, color: Colors.amber, size: 36),
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            _rating = index + 1;
          });
        },
        icon: Icon(Icons.star_border, color: Colors.grey, size: 36),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readMoreGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showingMore = !showingMore;
        });
      };
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    readMoreGestureRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyBroken.bookmark),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            widget.product.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmerInfo(
                            product: widget
                                .product), // implement farmer model then push it
                      ),
                    );
                  },
                  child: Text(
                    "by ${widget.product.farmer}",
                    // style: Theme.of(context).textTheme.bodyMedium,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available in stock",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "₹${widget.product.price}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: " / ${widget.product.unit}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: Colors.yellow.shade600,
              ),
              Text("${widget.product.rating} (192)"),
              const Spacer(),
              // SizedBox(
              //   width: 30,
              //   height: 30,
              //   child: IconButton.filled(
              //     padding: EdgeInsets.zero,
              //     onPressed: () {},
              //     iconSize: 18,
              //     icon: const Icon(Icons.remove),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "QTY : 2",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              // SizedBox(
              //   width: 30,
              //   height: 30,
              //   child: IconButton.filled(
              //     padding: EdgeInsets.zero,
              //     onPressed: () {},
              //     iconSize: 18,
              //     icon: const Icon(Icons.add),
              //   ),
              // ),
              const SizedBox(height: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Order Details",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Id: ${widget.order.id}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
                Text(
                  "Order Status: ${widget.order.status}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
                Text("Ordered On: ${widget.order.orderingDate}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600])),
                Text("Delivered On: ${widget.order.deliveryDate}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600])),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Related Products",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(products[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: products.length,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Feedback",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate the product:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Row(
                children: List.generate(5, (index) => _buildStar(index)),
              ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Slider(
                //         value: _rating,
                //         onChanged: (newRating) {
                //           setState(() {
                //             _rating = newRating;
                //           });
                //         },
                //         min: 0,
                //         max: 5,
                //         divisions: 5,
                //         label: _rating.toString(),
                //       ),
                //     ),
                //     Text(
                //       _rating.toString(),
                //       style: TextStyle(fontSize: 18),
                //     ),
                //   ],
                // ),
                SizedBox(height: 20),
                Text(
                  'Write your review:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _reviewController,
                  maxLength: 300,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your review here (max 300 words)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Logic to submit feedback
                        String review = _reviewController.text;
                        // print('Rating: $_rating');
                        // print('Review: $review');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Feedback Submitted!')),
                        );
                      }
                    },
                    child: const Text('Submit Feedback'),
                  ),
                ),
                // FilledButton.icon(
                //   onPressed: () {},
                //   icon: const Icon(IconlyLight.bag2),
                //   label: const Text("Add to card"),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
