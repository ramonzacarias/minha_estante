import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/widgets/search_result.dart';

class SearchResultsScreen extends StatelessWidget {
  final Map<String, dynamic> searchResult;

  const SearchResultsScreen({Key? key, required this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenTwo,
        title: Text(
          'Resultados da Pesquisa',
          textAlign: TextAlign.center,
        ),
      ),
      body: 
      SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 20.0),
              if (searchResult != null)
                SearchResults(searchResult: searchResult)
              else
                Expanded(
                  child: Center(child: Text('Nenhum resultado encontrado')),
                ),
            ],
          ),
        )
    );
  }
}