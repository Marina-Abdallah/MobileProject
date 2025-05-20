import 'dart:convert';

import 'package:first/quote/quote.dart';
import 'package:http/http.dart' as http;
Future <List<Quote>> fetchQuote() async{
  
  final response = await http.get(Uri.parse("https://api.api-ninjas.com/v1/quotes"),
    headers: {
    'X-Api-Key': 'KIxGTFPvP1K7r9UpWtf4Uw==EUs389wxOrOasVB4'
    },

  );

  if(response.statusCode==200){
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json)=>Quote.fromJson(json)).toList();
  }
  throw Exception("faild to load data");
}