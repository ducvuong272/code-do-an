import 'dart:async';

class CommentBloc {
  StreamController<int> _locationRatingController = StreamController<int>();
  Stream<int> get locationRatingStream => _locationRatingController.stream;
  StreamController<int> _priceRatingController = StreamController<int>();
  Stream<int> get priceRatingStream => _priceRatingController.stream;
  StreamController<int> _qualityRatingController = StreamController<int>();
  Stream<int> get qualityRatingStream => _qualityRatingController.stream;
  StreamController<int> _serviceRatingController = StreamController<int>();
  Stream<int> get serviceRatingStream => _serviceRatingController.stream;
  StreamController<int> _viewRatingController = StreamController<int>();
  Stream<int> get viewRatingStream => _viewRatingController.stream;

  onSliderChange(Stream stream, int value) {
    if(stream == locationRatingStream){
      _locationRatingController.sink.add(value);
    }
  }

  dispose() {
    _locationRatingController.close();
    _priceRatingController.close();
    _qualityRatingController.close();
    _serviceRatingController.close();
    _viewRatingController.close();
  }
}
