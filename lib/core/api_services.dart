import 'package:dio/dio.dart';
import 'package:ml_kit_akademi_examples/core/models/generateMessageRequest.dart';
import 'package:ml_kit_akademi_examples/core/models/textServices.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(
      "https://generativelanguage.googleapis.com/v1beta3/models/chat-bison-001:generateMessage?key=AIzaSyDNh2V6v95or8whnfwodLQsPTN3Tm_beKI")
  Future<MGenerateMessageResponse> getMessage(@Body() MGenerateMessageRequest generateMessageRequest);

  @POST(
      "https://generativelanguage.googleapis.com/v1beta3/models/text-bison-001:generateText?key=AIzaSyDNh2V6v95or8whnfwodLQsPTN3Tm_beKI")
  Future<GenerateTextResponse> getText(@Body() GenerateTextRequest generateTextRequest);
}
