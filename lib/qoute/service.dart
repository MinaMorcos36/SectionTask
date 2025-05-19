import 'dart:convert';

import 'package:sectiontask/qoute/quote.dart'; // Assuming your Quote class is here
import 'package:http/http.dart' as http;

Future<List<Quote>> fetchQuotes() async { // Changed return type to Future<List<Quote>>
  final response = await http.get(Uri.parse("https://api.api-ninjas.com/v1/quotes"),
    headers: {
      'X-Api-Key': 'AT8QdEBRUvNA8fFGS6BXrQ==LjdF7H5y1zhCIVZo'
    },
  ); // Added await

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Quote.fromJson(json as Map<String, dynamic>)).toList(); // Added type cast for safety
  } else {
    // Handle errors, for example, by throwing an exception
    throw Exception('Failed to load quotes: ${response.statusCode}');
  }
}