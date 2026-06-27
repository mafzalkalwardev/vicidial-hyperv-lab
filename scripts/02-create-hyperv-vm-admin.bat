@echo off
REM Re-launches the Hyper-V VM setup with Administrator rights (UAC prompt).
powershell -NoProfile -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""D:\Vicidail\scripts\02-create-hyperv-vm.ps1""'"
