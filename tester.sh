#! /bin/sh
#                __
#               / _)
#      _.----._/ /	dc0x13
#     /         /	part of `morse` project.
#  __/ (  | (  |	Mar 09 2025
# /__.-'|_|--|_|

if [ ! -e mrs ]; then
  echo "Cannot continue; run make"
  exit 0
fi

test_t_mode () {
  assertEquals    "$(./mrs t "hello world")"                              ".... . .-.. .-.. --- / .-- --- .-. .-.. -.. "
  assertEquals    "$(./mrs t "buenos dias")"                              "-... ..- . -. --- ... / -.. .. .- ... "
  assertEquals    "$(./mrs t "merci beaucoup")"                           "-- . .-. -.-. .. / -... . .- ..- -.-. --- ..- .--. "
  assertEquals    "$(./mrs t "hasta luego")"                              ".... .- ... - .- / .-.. ..- . --. --- "
  assertEquals    "$(./mrs t "see you soon")"                             "... . . / -.-- --- ..- / ... --- --- -. "
  assertEquals    "$(./mrs t "a bientot")"                                ".- / -... .. . -. - --- - "
  assertEquals    "$(./mrs t "good morning")"                             "--. --- --- -.. / -- --- .-. -. .. -. --. "
  assertEquals    "$(./mrs t "bonjour monde")"                            "-... --- -. .--- --- ..- .-. / -- --- -. -.. . "
  assertEquals    "$(./mrs t "hola mundo")"                               ".... --- .-.. .- / -- ..- -. -.. --- "
  assertEquals    "$(./mrs t "vive la france")"                           "...- .. ...- . / .-.. .- / ..-. .-. .- -. -.-. . "
  assertEquals    "$(./mrs t "hola")"                                     ".... --- .-.. .- "
  assertEquals    "$(./mrs t "july")"                                     ".--- ..- .-.. -.-- "
  assertEquals    "$(./mrs t "bEtWeEn DAYs")"                             "-... . - .-- . . -. / -.. .- -.-- ... "
  assertEquals    "$(./mrs t "house music!!!")"                           ".... --- ..- ... . / -- ..- ... .. -.-. ! ! ! "
  assertEquals    "$(./mrs t "39bermuda")"                                "...-- ----. -... . .-. -- ..- -.. .- "
}


test_m_mode () {
  assertEquals "$(./mrs m "--- .... / -.. --- ...- . !!!")" "oh dove!!!"
  assertEquals "$(./mrs m "... --- -- . - .... .. -. --. / ..--- / - .-. .- -. ... .-.. .- - . ")" "something 2 translate"
  assertEquals "$(./mrs m ".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --.. ----- ----. ---.. --... -.... ..... ....- ...-- ..--- .---- ")" "abcdefghijklmnopqrstuvwxyz0987654321"
  assertEquals "$(./mrs m "-.-- ..- -. --. .--. --- .-.. .- .-. ")" "yungpolar"
  assertEquals "$(./mrs m "-..- ---.. -.... ")" "x86"
}

. shunit2
