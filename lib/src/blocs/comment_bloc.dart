import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  Future<List<Asset>> multiImagePick() async {
    List<Asset> resultList = List<Asset>();
    resultList = await MultiImagePicker.pickImages(
      maxImages: 50,
      enableCamera: true,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: 'pick'),
      materialOptions: MaterialOptions(),
    );
    return resultList;
  }

  dispose() {
    _locationRatingController.close();
    _priceRatingController.close();
    _qualityRatingController.close();
    _serviceRatingController.close();
    _viewRatingController.close();
  }
}
