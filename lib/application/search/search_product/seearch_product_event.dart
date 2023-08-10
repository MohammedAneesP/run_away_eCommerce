part of 'seearch_product_bloc.dart';

@immutable
abstract class SearchProductEvent {}

class SearchResult extends SearchProductEvent {
  final String query;
  SearchResult({required this.query});
}
