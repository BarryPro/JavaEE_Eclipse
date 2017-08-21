@echo off
for %%i in (d:/batch/*.bat) do echo %%i >> tmp.txt
echo =======================
echo installed command list:
echo =======================
for /f "tokens=1,2,3 delims=:." %%i in (tmp.txt) do echo %%j
echo =======================
del tmp.txt
