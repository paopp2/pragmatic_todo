import 'dart:convert';

const List<Map<String, dynamic>> goodTestJsonUserList = [
  {
    "username": "userA",
    "password": "passA",
    "todos": [
      {"title": "titleAA", "content": "contentAA", "isDone": true},
      {"title": "titleAB", "content": "contentAB", "isDone": true}
    ]
  },
  {
    "username": "userB",
    "password": "passB",
    "todos": [
      {"title": "titleBA", "content": "contentBA", "isDone": false},
      {"title": "titleBB", "content": "contentBB", "isDone": false}
    ]
  },
];

const List<Map<String, dynamic>> badTestJsonData = [
  {
    "Data": "That",
    "Can't": "Be Parsed",
    "Okay?": true,
  }
];

Map<String, Object> goodPrefsJsonList = {
  "users": jsonEncode(goodTestJsonUserList),
};

Map<String, Object> goodPrefsRawString = {
  "goodstring": "Good String",
};

Map<String, Object> badSharedPrefsData = {
  "bad": jsonEncode(badTestJsonData),
};
