YodaTranslate
=====================

An iOS app that translates your messages to Yoda speak, and l33t speech too! Translations are generated with [mashape API](www.mashape.com), and a messaging style translation UI is built in part, with the  [PTSMessagingCell](https://github.com/ppanopticon/PTSMessagingCell) class. Choose a translation style, type a message, then the app responds with the translation.

![](http://i.imgur.com/V88UiKk.png)

Model View Controller Store
-----

This application is built with a MVCS design pattern. 

* YTTranslations is the model object that conforms data
* YTTranslator fetches API data
* YTranslationDataStore generates inital data and stores changes

Units Tests
----
Generated with the following Frameworks:
* [Specta](https://github.com/specta/specta)
* [Expecta](https://github.com/specta/expecta)
* [KIF](https://github.com/kif-framework/KIF)
