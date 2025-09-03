# lua-yandex-function

Lua Yandex Cloud Function Template

## Требования

-   [Visual Studio Code](https://code.visualstudio.com/download)
-   Lua. Можно в составе [LÖVE](https://love2d.org/) или [LuaForWindows](https://github.com/rjpcomputing/luaforwindows)
-   [Yandex Cloud (CLI)](https://yandex.cloud/ru/docs/cli/quickstart)
-   [Docker](https://www.docker.com/products/docker-desktop/)

## Примечания

1 - Использовать шаблон для создания функции  
2 - Настроить стили `.editorconfig`  
3 - Разместить нужную лицензию `LICENSE`

## Build & Deploy

### Локальный билд

Для упаковки функции в архив для загрузки в yandex cloud использовать билд таску или скрипты `build.bat`/`build.sh`

Используется докер контейнер с приближенной к yandex cloud function средой для создания архива с функцией.

### Локальный деплой

Для деплоя нужен [yc cli](https://yandex.cloud/ru/docs/cli/operations/install-cli) с настроенным профилем, облаком и каталогом. Через таску деплоя или напрямую используя yc:

`yc sls fn version create --function-id d4ej56******** --source-path ./dist/function.zip  --runtime bash-2204 --entrypoint handler.sh`

### CI/CD

Для CI/CD использовать [GitHub Actions](https://github.com/features/actions)

`build.yml` - создает архив с функцией, готовой для загрузки в облако.

`deploy.yml` - собирает и деплоит функцию в облако.
Совмещает `build.yml` и [GitHub Action to deploy Serverless Function to Yandex Cloud](https://github.com/yc-actions/yc-sls-function)

Потребуется в секретах передать креды аккаунта yandex cloud и id каталога:

-   YC_SA_JSON_CREDENTIALS
-   YC_FOLDER_ID

## Структура

```
├── /src
│   ├── /lib            Вспомогательные библиотеки
│   ├── debug.lua       Перехватчик для локального дебага
│   └── main.lua        Точка входа в функцию. Запрос приходит в stdin, ответ в stdout, логи в stderr. [manual](https://yandex.cloud/ru/docs/functions/concepts/function-invoke)
│
├── request.json        Тестовый запрос в правильном формате, используется для локального дебага
├── dist                Результат билда
```
