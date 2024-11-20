# lua-yandex-function
Lua Yandex Cloud Function Template

## Требования
Для разработки на Windows
- [Visual Studio Code](https://code.visualstudio.com/download)
- Lua. Можно в составе [LÖVE 11.4](https://love2d.org/) или [LuaForWindows](https://github.com/rjpcomputing/luaforwindows)
- WSL [WSL install](https://learn.microsoft.com/en-us/windows/wsl/install)
- В WSL собрать [LuaJIT](https://luajit.org/install.html) (опционально). Есть собранная версия в repo
- В WSL установить zip '''$ sudo apt-get install zip'''
- [Yandex Cloud (CLI) ](https://yandex.cloud/ru/docs/cli/quickstart)

## Примечания
1 - Использовать шаблон для создания функции
2 - Открыть `Workspace.code-workspace` и установить рекомендованные расширения
3 - Настроить стили `Root/.editorconfig`
4 - Разместить нужную лицензию `Root/LICENSE`

## WSL
Хост функции в облаке yandex на linux. Нужна WSL чтобы задать права файлам интерпретатора на исполнение.  
Также нужно собрать/взять готовые бинарники lua для linux. LuaJIT только из исходников, просто lua есть уже собранные.  
Функция загружается архивом со всеми нужными файлами.  
Приходится создавать его из под linux, так как на Windows теряются данные файловой системы о правах на исполнение. Иначе будет ошибка доступа в облаке

Прописываем права из под wsl
```
chmod +x luajit21
chmod +x lua54
```

Создание архива в билд скрипте
```
wsl zip func.zip func.sh luajit21 main.lua lib/*
```

## Структура
```
├── /src                
│   ├── /lib            Вспомогательные библиотеки  
│   ├── debug.lua       Перехватчик для локального дебага  
│   └── main.lua        Точка входа в функцию. Запрос приходит в stdin, ответ в stdout, логи в stderr. [manual](https://yandex.cloud/ru/docs/functions/concepts/function-invoke)  
│  
├── resources           Вспомогательные ресурсы
│   ├── build.bat       Билд скрипт для создания архива с функцией 
│   ├── deploy.bat      Билд и загрузка функции в облако. Нужно указать актуальный id функции --function-id d4ej56********
│   ├── func.sh         bash скрипт вызова lua в облаке. Нет готовой среды для Lua 
│   ├── lua54           Интерпретатор [Lua](https://www.lua.org/) Использовать, если нет функционала в LuaJIT
│   ├── luajit21        [LuaJIT](https://luajit.org/luajit.html) Более быстрая версия lua, используем по умолчанию
│   └── request.json    Тестовый запрос в правильном формате, используется для локального дебага 
│  
├── builds              Результат билда
```