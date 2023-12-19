import 'package:ml_kit_akademi_examples/core/api_services.dart';
import 'package:ml_kit_akademi_examples/core/models/generateMessageRequest.dart';
import 'package:ml_kit_akademi_examples/core/models/textServices.dart';

class Repository {
  final ApiService apiService;

  Repository(
    this.apiService,
  );

  Future<MGenerateMessageResponse> getMessage(MGenerateMessageRequest generateMessageRequest) async {
    return await apiService.getMessage(generateMessageRequest);
  }

  Future<GenerateTextResponse> getText(GenerateTextRequest generateTextRequest) async {
    return await apiService.getText(generateTextRequest);
  }
}
