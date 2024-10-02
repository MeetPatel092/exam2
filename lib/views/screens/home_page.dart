import 'package:flutter/material.dart';

import '../../helpers/db_helper.dart';
import '../../models/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DbModel>> getAllData;
  List<DbModel> products = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController productController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  bool istap = false;

  Future<void> fetchProducts() async {
    products = await DbHelper.dbHelper.fetchData();
    setState(() {});
  }

  void initState() {
    super.initState();
    fetchProducts();

    getAllData = DbHelper.dbHelper.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    istap = false;
                  });
                },
                child: Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: istap ? Colors.black : Colors.teal,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    istap = true;
                  });
                },
                child: Text(
                  "Show Product",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: istap ? Colors.teal : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          istap
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    (products.isEmpty)
                        ? const Text("No products available",
                            style: TextStyle(fontSize: 18))
                        : ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [],
                                  ),
                                  title: Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: formKey,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter the Product name",
                          hintStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        controller: productController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a product name";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text("Add Product"),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
