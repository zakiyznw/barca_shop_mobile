import 'package:flutter/material.dart';
import 'package:barca_shop/models/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fields = product.fields;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(fields.thumbnail)}',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                /// Name
                Text(
                  fields.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                /// Category
                Text(
                  'Category: ${fields.category}',
                  style: const TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 6),

                /// Price
                Text(
                  'Price: Rp ${fields.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 6),

                /// Stock
                Text(
                  'Stock: ${fields.stock}',
                  style: const TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 6),

                /// Description preview
                Text(
                  fields.description.length > 100
                      ? '${fields.description.substring(0, 100)}...'
                      : fields.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),

                /// Rating
                Text(
                  'Rating: ${fields.rating} (${fields.totalRatings} reviews)',
                  style: const TextStyle(color: Colors.orange),
                ),

                /// Featured badge
                if (fields.isFeatured)
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      'Featured Product',
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
