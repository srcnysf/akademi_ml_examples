import 'package:flutter/material.dart';
import 'package:ml_kit_akademi_examples/core/models/generateMessageRequest.dart';
import 'package:ml_kit_akademi_examples/core/models/textServices.dart';
import 'package:ml_kit_akademi_examples/ui/main/main_view_model.dart';
// import 'package:palm_api/palm_api.dart';
// import 'package:palm_api/palm_api.dart';

class PalmViewModel extends MainViewModel {
  // final palm = TextService(apiKey: 'AIzaSyDNh2V6v95or8whnfwodLQsPTN3Tm_beKI');
  // final palmMesage = DiscussService(apiKey: 'AIzaSyDNh2V6v95or8whnfwodLQsPTN3Tm_beKI');
  GenerateTextResponse? generatedText;
  MGenerateMessageResponse? generatedMessage;
  TextEditingController controller = TextEditingController();

  init() {}

  generateText() async {
    // if (controller.text.isNotEmpty) {
    //   generatedText = await palm.generateText(
    //     model: PalmModel.textBison001.name, // or 'text-bison-001'
    //     temperature: 0.1,
    //     candidateCount: 3,
    //     prompt: TextPrompt(text: controller.text),
    //   );
    //   notifyListeners();
    // }
  }

  generateMessage() async {
    // if (controller.text.isNotEmpty) {
    //   List<Message> messages = [Message(content: controller.text, author: "User")];
    //   generatedMessage = await palmMesage.generateMessage(
    //     model: PalmModel.textBison001.name, // or 'text-bison-001'
    //     prompt: MessagePrompt(
    //       messages: messages,
    //       context: "Coding",
    //     ),
    //   );
    //   notifyListeners();
    // }
  }

  generateMessageFromRESTService() async {
    List<Message> messages = [Message(content: controller.text, author: "User")];

    MGenerateMessageRequest generateMessageRequest = MGenerateMessageRequest(
        model: "chat-bison-001",
        temperature: 0.7,
        prompt: MessagePrompt(
          messages: messages,
          context: "Coding",
        ));
    generatedMessage = await repository.getMessage(generateMessageRequest);
    notifyListeners();
  }

  generateTextFromRESTService() async {
    GenerateTextRequest generateTextRequest = GenerateTextRequest(
        model: "text-bison-001", temperature: 0.7, candidateCount: 1, prompt: TextPrompt(text: controller.text));
    generatedText = await repository.getText(generateTextRequest);
    notifyListeners();
  }
}
