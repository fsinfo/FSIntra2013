FSIntra2013
===========

Die alte Mär vom neuen Intranet, im Gewand von 2013. Wetten, dass... das auch nix wird?

Installation
============

* Die Datei `config/initializers/api_users.rb.example` sollte nach `config/initializers/api_users.rb` kopiert und angepasst werden.
* Die Datei `config/initializers/secret_token.rb.template` sollte nach `config/initializers/secret_token.rb` kopiert und ein z.B. mit `rake secret` generierter Key eingefügt werden.
* Der Host in `config/application.rb` sollte angepasst werden, damit die URLs in Mails richtig erstellt werden.
