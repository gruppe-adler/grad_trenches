@echo off

if exist a3 (
  rmdir a3
)
mklink /j a3 include\a3

mkdir x
mkdir x\grad_trenches
if exist x\grad_trenches\addons (
  rmdir x\grad_trenches\addons
)
mklink /j x\grad_trenches\addons addons

hemtt build --force --release
set BUILD_STATUS=%errorlevel%

rmdir a3
rmdir x\grad_trenches\addons
rmdir x\grad_trenches
rmdir x

if %BUILD_STATUS% neq 0 (
  echo Build failed
  exit /b %errorlevel%
) else (
  echo Build successful
)
