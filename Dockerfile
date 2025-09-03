FROM ubuntu:22.04

# Установка зависимостей
RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	zip \
	&& rm -rf /var/lib/apt/lists/*

# Создаем рабочую директорию
WORKDIR /app

# Клонируем и собираем LuaJIT
RUN git clone https://github.com/LuaJIT/LuaJIT.git
WORKDIR /app/LuaJIT
RUN git checkout v2.1
RUN make

# Копируем исходные файлы проекта
COPY ./src /app/src

# Создаем функцию в /function
RUN mkdir -p /function/lib

# Копируем LuaJIT бинарник
RUN cp /app/LuaJIT/src/luajit /function/

# Копируем Lua файлы
RUN cp /app/src/main.lua /function/

# Копируем библиотеки
RUN cp /app/src/lib/* /function/lib/

# Создаем handler.sh
RUN echo './luajit main.lua' > /function/handler.sh

# Устанавливаем права на выполнение
RUN chmod +x /function/luajit
RUN chmod +x /function/handler.sh

# Создаем ZIP архив
WORKDIR /function
RUN zip -r /function.zip ./*

# Копируем архив в output директорию
RUN mkdir -p /output
RUN cp /function.zip /output/
