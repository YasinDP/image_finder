import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_finder/models.dart';

class ImagesImplementation {
  static Future<List<ImageItem>> fetchPaginatedImages(
    String query, {
    required int offset,
    required int pageSize,
  }) async {
    int page = (offset / pageSize).ceil() + 1;
    try {
      String url =
          "https://pixabay.com/api/?key=43496913-a8e7b1e444407ab2e6ec24550&q=${Uri.encodeQueryComponent(query)}&image_type=photo&page=$page&per_page=$pageSize";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Decode the JSON response
        final jsonResponse = json.decode(response.body);
        // Return the list of objects
        List objects = jsonResponse['hits'];
        return objects
            .map((e) => ImageItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      // Catch any exceptions during the HTTP request
      debugPrint('Failed to fetch data: $error');
      return [];
    }
  }
}
