import 'dart:io';

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void main() async {
  // String message = '';

  var BOT_TOKEN = '6614464601:AAH8TWvonumBra2wsQXtKQY6eR6UCwUpyBQ';
  final username = (await Telegram(BOT_TOKEN).getMe()).username;
  var teledart = TeleDart(BOT_TOKEN, Event(username!));

  teledart.start();

  teledart.onMessage(keyword: 'Fight for freedom').listen((message) {
    message.reply('Stand with Hong Kong');
  });

  teledart
      .onMessage(entityType: 'bot_command', keyword: 'start')
      .listen((message) {
    teledart.sendMessage(message.chat.id,
        'Assalomu alaykum! Matnni o\'zgartirish uchun yuboring...');
  });

  teledart
      .onMessage(entityType: 'bot_command', keyword: 'getcode')
      .listen((message) {
    var file = File('tgbot.txt');
    teledart.sendDocument(message.chat.id, file.readAsBytesSync(),);
  });

  teledart.onMessage().listen((msg) {
    var transformedText =
        transformText(msg.text ?? "Iltimos xabar kiriting !!!");
    teledart.sendMessage(msg.chat.id, transformedText);
  });
}

String transformText(String text) {
  var transformations = {
    'a': 'а',
    'b': 'б',
    'd': 'д',
    'e': 'е',
    'f': 'ф',
    'g': 'г',
    'h': 'х',
    'i': 'и',
    'j': 'ж',
    'k': 'к',
    'l': 'л',
    'm': 'м',
    'n': 'н',
    'o': 'о',
    'p': 'п',
    'q': 'қ',
    'r': 'р',
    's': 'с',
    't': 'т',
    'u': 'у',
    'v': 'в',
    'x': 'ҳ',
    'y': 'й',
    'z': 'з',
    'o\'': 'ў',
    'g\'': 'ғ',
    'sh': 'ш',
    'ch': 'ч',
    '`': 'ъ',
  };

  var transformedText = '';

  for (var char in text.split('')) {
    var transformedChar = transformations[char.toLowerCase()];
    transformedText += transformedChar ?? char;
  }

  return transformedText;
}
