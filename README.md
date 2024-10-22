# README

на ветке search_with_turbo была идея реализовать замену только содержимого фрейма products. Который должен был обновляться сразуже после установки галочки. 

https://code.avi.nyc/turbo-frame-search-filters
https://github.com/aviflombaum/turbo-search-filters/blob/main/app/javascript/controllers/filter_controller.js

Для этого добавлен контроллер стимулус и data: {action: "change->filter#submit"} в поля формы поиска.
И кончно же форма подключена к контроллеру стимулус: data: {controller: "filter"}
