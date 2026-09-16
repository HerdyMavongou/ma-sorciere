#!/usr/bin/env bash
# Construit l'APK de Ma Sorciere de bout en bout.
# Prerequis : Flutter installe + SDK Android (flutter doctor sans erreur).
set -e

cd "$(dirname "$0")"

echo "==> Generation du dossier android/"
flutter create --org com.herdy --project-name ma_sorciere --platforms=android .

echo "==> Application des patchs Android"
python3 tool/patch_android.py

echo "==> Dependances"
flutter pub get

echo "==> Compilation de l'APK (release)"
flutter build apk --release

echo
echo "APK genere : build/app/outputs/flutter-apk/app-release.apk"
