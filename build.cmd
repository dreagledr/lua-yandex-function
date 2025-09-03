@echo off
echo Building LuaJIT function package using Docker...

docker build -t luajit-function-builder .
for /f %%i in ('docker create luajit-function-builder') do set CONTAINER_ID=%%i
docker cp %CONTAINER_ID%:/output/function.zip dist/function.zip
docker rm %CONTAINER_ID%

echo Build complete! Package created: dist/function.zip
dir "dist\function.zip"
