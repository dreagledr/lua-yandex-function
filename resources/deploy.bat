rd /S /Q ..\builds\output
mkdir ..\builds\output
mkdir ..\builds\output\lib
copy ..\resources\func.sh ..\builds\output\
copy ..\resources\luajit21 ..\builds\output\
copy main.lua ..\builds\output\
xcopy /V .\lib\*.lua ..\builds\output\lib\
cd ..\builds\output
wsl zip func.zip func.sh luajit21 main.lua lib/*
yc sls fn version create --function-id d4ej56******** --source-path func.zip  --runtime bash-2204 --entrypoint func.sh