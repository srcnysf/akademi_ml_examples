import 'package:palm_api/src/dto/citation.dto.dart';
import 'package:palm_api/src/dto/safety.dto.dart';
import 'package:palm_api/src/helpers/deep_collection_equality.dart';

/// Request to generate a message.

class MGenerateMessageRequest {
  final String model;

  final MessagePrompt prompt;

  final double? temperature;

  final int? candidateCount;

  final double? topP;

  final int? topK;

  MGenerateMessageRequest({
    required this.model,
    required this.prompt,
    this.temperature,
    this.candidateCount,
    this.topP,
    this.topK,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MGenerateMessageRequest &&
        other.model == model &&
        other.prompt == prompt &&
        other.temperature == temperature &&
        other.candidateCount == candidateCount &&
        other.topP == topP &&
        other.topK == topK;
  }

  @override
  int get hashCode {
    return model.hashCode ^
        prompt.hashCode ^
        temperature.hashCode ^
        candidateCount.hashCode ^
        topP.hashCode ^
        topK.hashCode;
  }

  MGenerateMessageRequest copyWith({
    String? model,
    MessagePrompt? prompt,
    double? temperature,
    int? candidateCount,
    double? topP,
    int? topK,
  }) {
    return MGenerateMessageRequest(
      model: model ?? this.model,
      prompt: prompt ?? this.prompt,
      temperature: temperature ?? this.temperature,
      candidateCount: candidateCount ?? this.candidateCount,
      topP: topP ?? this.topP,
      topK: topK ?? this.topK,
    );
  }

  @override
  String toString() {
    return 'GenerateMessageRequest(model: $model, prompt: $prompt, temperature: $temperature, candidateCount: $candidateCount, topP: $topP, topK: $topK)';
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'prompt': prompt.toJson(),
      'temperature': temperature,
      'candidateCount': candidateCount,
      'topP': topP,
      'topK': topK,
    };
  }

  factory MGenerateMessageRequest.fromJson(Map<String, dynamic> map) {
    return MGenerateMessageRequest(
      model: map['model'] ?? '',
      prompt: MessagePrompt.fromJson(map['prompt']),
      temperature: map['temperature']?.toDouble(),
      candidateCount: map['candidateCount']?.toInt(),
      topP: map['topP']?.toDouble(),
      topK: map['topK']?.toInt(),
    );
  }
}

/// The response from the model.
///
/// This includes candidate messages and
/// conversation history in the form of chronologically-ordered messages.

class MGenerateMessageResponse {
  final List<Message> candidates;

  final List<Message> messages;

  final List<ContentFilter> filters;

  MGenerateMessageResponse({
    required this.candidates,
    required this.messages,
    required this.filters,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MGenerateMessageResponse &&
        listEquals(other.candidates, candidates) &&
        listEquals(other.messages, messages) &&
        listEquals(other.filters, filters);
  }

  @override
  int get hashCode => candidates.hashCode ^ messages.hashCode ^ filters.hashCode;

  MGenerateMessageResponse copyWith({
    List<Message>? candidates,
    List<Message>? messages,
    List<ContentFilter>? filters,
  }) {
    return MGenerateMessageResponse(
      candidates: candidates ?? this.candidates,
      messages: messages ?? this.messages,
      filters: filters ?? this.filters,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates.map((x) => x.toJson()).toList(),
      'messages': messages.map((x) => x.toJson()).toList(),
      'filters': filters.map((x) => x.toJson()).toList(),
    };
  }

  factory MGenerateMessageResponse.fromJson(Map<String, dynamic> map) {
    return MGenerateMessageResponse(
      candidates: List<Message>.from(map['candidates']?.map((x) => Message.fromJson(x)) ?? []),
      messages: List<Message>.from(map['messages']?.map((x) => Message.fromJson(x)) ?? []),
      filters: List<ContentFilter>.from(map['filters']?.map((x) => ContentFilter.fromJson(x)) ?? []),
    );
  }

  @override
  String toString() => 'GenerateMessageResponse(candidates: $candidates, messages: $messages, filters: $filters)';
}

/// The base unit of structured text.
///
/// A `Message` includes an `author` and the `content` of
/// the `Message`.
///
/// The `author` is used to tag messages when they are fed to the
/// model as text.

class Message {
  final String? author;

  final String content;

  final CitationMetadata? citationMetadata;

  Message({
    this.author,
    required this.content,
    this.citationMetadata,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.author == author &&
        other.content == content &&
        other.citationMetadata == citationMetadata;
  }

  @override
  int get hashCode => author.hashCode ^ content.hashCode ^ citationMetadata.hashCode;

  Message copyWith({
    String? author,
    String? content,
    CitationMetadata? citationMetadata,
  }) {
    return Message(
      author: author ?? this.author,
      content: content ?? this.content,
      citationMetadata: citationMetadata ?? this.citationMetadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': content,
      'citationMetadata': citationMetadata?.toJson(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      author: map['author'],
      content: map['content'] ?? '',
      citationMetadata: map['citationMetadata'] != null ? CitationMetadata.fromJson(map['citationMetadata']) : null,
    );
  }

  @override
  String toString() => 'Message(author: $author, content: $content, citationMetadata: $citationMetadata)';
}

/// between the user and the model.

class MessagePrompt {
  final String? context;

  final List<Example>? examples;

  final List<Message> messages;

  MessagePrompt({
    this.context,
    this.examples,
    required this.messages,
  });

  @override
  String toString() => 'MessagePrompt(context: $context, examples: $examples, messages: $messages)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MessagePrompt &&
        other.context == context &&
        listEquals(other.examples, examples) &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode => context.hashCode ^ examples.hashCode ^ messages.hashCode;

  MessagePrompt copyWith({
    String? context,
    List<Example>? examples,
    List<Message>? messages,
  }) {
    return MessagePrompt(
      context: context ?? this.context,
      examples: examples ?? this.examples,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'context': context,
      'examples': examples?.map((x) => x.toJson()).toList(),
      'messages': messages.map((x) => x.toJson()).toList(),
    };
  }

  factory MessagePrompt.fromJson(Map<String, dynamic> map) {
    return MessagePrompt(
      context: map['context'],
      examples: map['examples'] != null ? List<Example>.from(map['examples']?.map((x) => Example.fromJson(x))) : null,
      messages: List<Message>.from(map['messages']?.map((x) => Message.fromJson(x))),
    );
  }
}

class Example {
  /// Required. An example of an input `Message` from the user.
  final Message input;

  /// Required. An example of what the model should output given the input.
  final Message output;

  Example({
    required this.input,
    required this.output,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Example && other.input == input && other.output == output;
  }

  @override
  int get hashCode => input.hashCode ^ output.hashCode;

  Example copyWith({
    Message? input,
    Message? output,
  }) {
    return Example(
      input: input ?? this.input,
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input': input.toJson(),
      'output': output.toJson(),
    };
  }

  factory Example.fromJson(Map<String, dynamic> map) {
    return Example(
      input: Message.fromJson(map['input']),
      output: Message.fromJson(map['output']),
    );
  }

  @override
  String toString() => 'Example(input: $input, output: $output)';
}

/// Counts the number of tokens in the `prompt` sent to a model.
///
/// Models may tokenize text differently, so each model may return a different
/// `tokenCount`.

class CountMessageTokensRequest {
  final String model;

  final MessagePrompt prompt;

  CountMessageTokensRequest({
    required this.model,
    required this.prompt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountMessageTokensRequest && other.model == model && other.prompt == prompt;
  }

  @override
  int get hashCode => model.hashCode ^ prompt.hashCode;

  CountMessageTokensRequest copyWith({
    String? model,
    MessagePrompt? prompt,
  }) {
    return CountMessageTokensRequest(
      model: model ?? this.model,
      prompt: prompt ?? this.prompt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'prompt': prompt.toJson(),
    };
  }

  factory CountMessageTokensRequest.fromJson(Map<String, dynamic> map) {
    return CountMessageTokensRequest(
      model: map['model'] ?? '',
      prompt: MessagePrompt.fromJson(map['prompt']),
    );
  }

  @override
  String toString() => 'CountMessageTokensRequest(model: $model, prompt: $prompt)';
}

/// A response from `CountMessageTokens`.
///
/// It returns the model's `token_count` for the `prompt`.

class CountMessageTokensResponse {
  final int tokenCount;

  CountMessageTokensResponse({
    required this.tokenCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountMessageTokensResponse && other.tokenCount == tokenCount;
  }

  @override
  int get hashCode => tokenCount.hashCode;

  CountMessageTokensResponse copyWith({
    int? tokenCount,
  }) {
    return CountMessageTokensResponse(
      tokenCount: tokenCount ?? this.tokenCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenCount': tokenCount,
    };
  }

  factory CountMessageTokensResponse.fromJson(Map<String, dynamic> map) {
    return CountMessageTokensResponse(
      tokenCount: map['tokenCount']?.toInt() ?? 0,
    );
  }

  @override
  String toString() => 'CountMessageTokensResponse(tokenCount: $tokenCount)';
}
