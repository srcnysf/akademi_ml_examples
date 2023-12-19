import 'package:flutter/material.dart';
import 'package:ml_kit_akademi_examples/ui/palm_example/palm_example_view_model.dart';
import 'package:stacked/stacked.dart';

class PampExampleView extends StatelessWidget {
  const PampExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PalmViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: model.controller,
                      decoration: InputDecoration(hintText: 'Put you prompt'),
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        model.generateTextFromRESTService();
                      },
                      child: Text("Generate Text"),
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        model.generateMessageFromRESTService();
                      },
                      child: Text("Generate Message"),
                    ),
                    Text(model.generatedText?.candidates[0].output ?? ""),
                    Text(model.generatedMessage?.candidates[0].content ?? "")
                  ],
                ),
              ),
            )));
  }
}
