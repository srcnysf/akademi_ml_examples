import 'dart:core';

import 'package:palm_api/src/dto/citation.dto.dart';
import 'package:palm_api/src/dto/safety.dto.dart';
import 'package:palm_api/src/helpers/deep_collection_equality.dart';

class GenerateTextRequest {
  final String model;

  final TextPrompt prompt;

  final double? temperature;

  final int? candidateCount;

  final int? maxOutputTokens;

  final double? topP;

  final int? topK;

  final List<SafetySetting>? safetySettings;

  final List<String>? stopSequences;

  GenerateTextRequest({
    required this.model,
    required this.prompt,
    this.temperature,
    this.candidateCount,
    this.maxOutputTokens,
    this.topP,
    this.topK,
    this.safetySettings,
    this.stopSequences,
  });

  @override
  String toString() {
    return 'GenerateTextRequest(model: $model, prompt: $prompt, temperature: $temperature, candidateCount: $candidateCount, maxOutputTokens: $maxOutputTokens, topP: $topP, topK: $topK, safetySettings: $safetySettings, stopSequences: $stopSequences)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GenerateTextRequest &&
        other.model == model &&
        other.prompt == prompt &&
        other.temperature == temperature &&
        other.candidateCount == candidateCount &&
        other.maxOutputTokens == maxOutputTokens &&
        other.topP == topP &&
        other.topK == topK &&
        listEquals(other.safetySettings, safetySettings) &&
        listEquals(other.stopSequences, stopSequences);
  }

  @override
  int get hashCode {
    return model.hashCode ^
        prompt.hashCode ^
        temperature.hashCode ^
        candidateCount.hashCode ^
        maxOutputTokens.hashCode ^
        topP.hashCode ^
        topK.hashCode ^
        safetySettings.hashCode ^
        stopSequences.hashCode;
  }

  GenerateTextRequest copyWith({
    String? model,
    TextPrompt? prompt,
    double? temperature,
    int? candidateCount,
    int? maxOutputTokens,
    double? topP,
    int? topK,
    List<SafetySetting>? safetySettings,
    List<String>? stopSequences,
  }) {
    return GenerateTextRequest(
      model: model ?? this.model,
      prompt: prompt ?? this.prompt,
      temperature: temperature ?? this.temperature,
      candidateCount: candidateCount ?? this.candidateCount,
      maxOutputTokens: maxOutputTokens ?? this.maxOutputTokens,
      topP: topP ?? this.topP,
      topK: topK ?? this.topK,
      safetySettings: safetySettings ?? this.safetySettings,
      stopSequences: stopSequences ?? this.stopSequences,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'prompt': prompt.toJson(),
      'temperature': temperature,
      'candidateCount': candidateCount,
      'maxOutputTokens': maxOutputTokens,
      'topP': topP,
      'topK': topK,
      'safetySettings': safetySettings?.map((x) => x.toJson()).toList(),
      'stopSequences': stopSequences,
    };
  }

  factory GenerateTextRequest.fromJson(Map<String, dynamic> map) {
    return GenerateTextRequest(
      model: map['model'] ?? '',
      prompt: TextPrompt.fromJson(map['prompt']),
      temperature: map['temperature']?.toDouble(),
      candidateCount: map['candidateCount']?.toInt(),
      maxOutputTokens: map['maxOutputTokens']?.toInt(),
      topP: map['topP']?.toDouble(),
      topK: map['topK']?.toInt(),
      safetySettings: map['safetySettings'] != null
          ? List<SafetySetting>.from(map['safetySettings']?.map((x) => SafetySetting.fromJson(x)))
          : null,
      stopSequences: List<String>.from(map['stopSequences']),
    );
  }
}

class GenerateTextResponse {
  final List<TextCompletion> candidates;

  final List<ContentFilter> filters;

  final List<SafetyFeedback> safetyFeedback;

  GenerateTextResponse({
    required this.candidates,
    required this.filters,
    required this.safetyFeedback,
  });

  @override
  String toString() =>
      'GenerateTextResponse(candidates: $candidates, filters: $filters, safetyFeedback: $safetyFeedback)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is GenerateTextResponse &&
        listEquals(other.candidates, candidates) &&
        listEquals(other.filters, filters) &&
        listEquals(other.safetyFeedback, safetyFeedback);
  }

  @override
  int get hashCode => candidates.hashCode ^ filters.hashCode ^ safetyFeedback.hashCode;

  GenerateTextResponse copyWith({
    List<TextCompletion>? candidates,
    List<ContentFilter>? filters,
    List<SafetyFeedback>? safetyFeedback,
  }) {
    return GenerateTextResponse(
      candidates: candidates ?? this.candidates,
      filters: filters ?? this.filters,
      safetyFeedback: safetyFeedback ?? this.safetyFeedback,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates.map((x) => x.toJson()).toList(),
      'filters': filters.map((x) => x.toJson()).toList(),
      'safetyFeedback': safetyFeedback.map((x) => x.toJson()).toList(),
    };
  }

  factory GenerateTextResponse.fromJson(Map<String, dynamic> map) {
    return GenerateTextResponse(
      candidates: List<TextCompletion>.from(map['candidates']?.map((x) => TextCompletion.fromJson(x)) ?? []),
      filters: List<ContentFilter>.from(map['filters']?.map((x) => ContentFilter.fromJson(x)) ?? []),
      safetyFeedback: List<SafetyFeedback>.from(map['safetyFeedback']?.map((x) => SafetyFeedback.fromJson(x)) ?? []),
    );
  }
}

class TextPrompt {
  // Required. The prompt text.
  final String text;

  TextPrompt({
    required this.text,
  });

  @override
  String toString() => 'TextPrompt(text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextPrompt && other.text == text;
  }

  @override
  int get hashCode => text.hashCode;

  TextPrompt copyWith({
    String? text,
  }) {
    return TextPrompt(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }

  factory TextPrompt.fromJson(Map<String, dynamic> map) {
    return TextPrompt(
      text: map['text'] ?? '',
    );
  }
}

class TextCompletion {
  // Output only. The generated text returned from the model.
  final String output;

  // Ratings for the safety of a response.
  //
  // There is at most one rating per category.
  // final List<SafetyRating> safetyRatings;

  // Output only. Citation information for model-generated `output` in this
  // `TextCompletion`.
  //
  // This field may be populated with attribution information for any text
  // included in the `output`.
  final CitationMetadata? citationMetadata;

  TextCompletion({
    required this.output,
    // required this.safetyRatings,
    this.citationMetadata,
  });

  TextCompletion copyWith({
    String? output,
    // List<SafetyRating>? safetyRatings,
    CitationMetadata? citationMetadata,
  }) {
    return TextCompletion(
      output: output ?? this.output,
      // safetyRatings: safetyRatings ?? this.safetyRatings,
      citationMetadata: citationMetadata ?? this.citationMetadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'output': output,
      // 'safetyRatings': safetyRatings.map((x) => x.toJson()).toList(),
      'citationMetadata': citationMetadata?.toJson(),
    };
  }

  factory TextCompletion.fromJson(Map<String, dynamic> map) {
    return TextCompletion(
      output: map['output'] ?? '',
      // safetyRatings: List<SafetyRating>.from(map['safetyRatings']?.map((x) => SafetyRating.fromJson(x))),
      citationMetadata: map['citationMetadata'] != null ? CitationMetadata.fromJson(map['citationMetadata']) : null,
    );
  }
}

class EmbedTextRequest {
  // Required. The model name to use with the format model=models/{model}.
  final String model;

  // Required. The free-form input text that the model will turn into an
  // embedding.
  final String text;

  EmbedTextRequest({
    required this.model,
    required this.text,
  });

  @override
  String toString() => 'EmbedTextRequest(model: $model, text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmbedTextRequest && other.model == model && other.text == text;
  }

  @override
  int get hashCode => model.hashCode ^ text.hashCode;

  EmbedTextRequest copyWith({
    String? model,
    String? text,
  }) {
    return EmbedTextRequest(
      model: model ?? this.model,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'text': text,
    };
  }

  factory EmbedTextRequest.fromJson(Map<String, dynamic> map) {
    return EmbedTextRequest(
      model: map['model'] ?? '',
      text: map['text'] ?? '',
    );
  }
}

class EmbedTextResponse {
  // Output only. The embedding generated from the input text.
  final Embedding? embedding;

  EmbedTextResponse({
    this.embedding,
  });

  @override
  String toString() => 'EmbedTextResponse(embedding: $embedding)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmbedTextResponse && other.embedding == embedding;
  }

  @override
  int get hashCode => embedding.hashCode;

  EmbedTextResponse copyWith({
    Embedding? embedding,
  }) {
    return EmbedTextResponse(
      embedding: embedding ?? this.embedding,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'embedding': embedding?.toJson(),
    };
  }

  factory EmbedTextResponse.fromJson(Map<String, dynamic> map) {
    return EmbedTextResponse(
      embedding: map['embedding'] != null ? Embedding.fromJson(map['embedding']) : null,
    );
  }
}

class Embedding {
  // The embedding values.
  final List<double> value;

  Embedding({
    required this.value,
  });

  @override
  String toString() => 'Embedding(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Embedding && listEquals(other.value, value);
  }

  @override
  int get hashCode => value.hashCode;

  Embedding copyWith({
    List<double>? value,
  }) {
    return Embedding(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  factory Embedding.fromJson(Map<String, dynamic> map) {
    return Embedding(
      value: List<double>.from(map['value']),
    );
  }
}
