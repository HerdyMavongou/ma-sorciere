# Obtenir le fichier .apk de Ma Sorcière ❤️

Trois voies, de la plus simple à la plus technique.

---

## Voie A — GitHub Actions (aucune installation, ~10 min)

C'est la méthode recommandée si tu n'as pas Android Studio. GitHub compile le projet
sur ses serveurs, gratuitement, et te rend l'APK en téléchargement.

1. Crée un compte sur <https://github.com> puis un dépôt **privé** nommé `ma-sorciere`.
2. Décompresse `ma_sorciere.zip` et envoie son contenu dans le dépôt.
   - Soit par le site : bouton **Add file → Upload files**, glisse tout le contenu du
     dossier `ma_sorciere` (y compris le dossier caché `.github`), puis **Commit**.
   - Soit en ligne de commande :
     ```bash
     cd ma_sorciere
     git init && git add -A && git commit -m "Ma Sorciere"
     git branch -M main
     git remote add origin https://github.com/TON_COMPTE/ma-sorciere.git
     git push -u origin main
     ```
3. Onglet **Actions** du dépôt → le workflow « Construire l'APK Ma Sorcière » démarre
   tout seul. S'il ne démarre pas, clique dessus puis **Run workflow**.
4. Quand le rond devient vert (8 à 12 min), ouvre l'exécution et télécharge l'artefact
   **ma-sorciere-apk** en bas de la page. Il contient `app-release.apk`.

> Si tu uploades par le site web, vérifie que le dossier `.github/workflows/` est bien
> présent : certains navigateurs ignorent les dossiers commençant par un point. En cas de
> doute, crée le fichier manuellement via **Add file → Create new file** en tapant le
> chemin `.github/workflows/build-apk.yml`.

---

## Voie B — Sur ton ordinateur (si Flutter est installé)

```bash
cd ma_sorciere
./build_apk.sh
```

Le script génère `android/`, applique les 3 patchs, puis compile.
Résultat : `build/app/outputs/flutter-apk/app-release.apk`

Sous Windows (PowerShell) :

```powershell
cd ma_sorciere
flutter create --org com.herdy --project-name ma_sorciere --platforms=android .
python tool\patch_android.py
flutter pub get
flutter build apk --release
```

Prérequis : `flutter doctor` doit être vert pour « Flutter » et « Android toolchain ».

---

## Voie C — Codemagic (alternative cloud à GitHub Actions)

<https://codemagic.io> propose des minutes gratuites. Connecte le dépôt GitHub créé en
voie A, choisis « Flutter App (Android) », mode release, et ajoute en pré-build :

```
flutter create --org com.herdy --project-name ma_sorciere --platforms=android .
python3 tool/patch_android.py
```

---

## Installer l'APK sur le téléphone

1. Transfère `app-release.apk` sur le téléphone (câble USB, Bluetooth, Google Drive…).
2. Ouvre-le depuis le gestionnaire de fichiers.
3. Android demandera d'autoriser « l'installation d'applications inconnues » pour
   l'application depuis laquelle tu ouvres le fichier : accepte.
4. À la première ouverture, accepte les notifications.

L'APK est signé avec la clé de debug : il s'installe parfaitement, il ne peut simplement
pas être publié sur le Play Store. Pour une vraie clé de signature, voir la section 4 du
`README.md`.

---

## Si la compilation échoue

Copie-moi le message d'erreur du journal (onglet Actions → l'étape rouge) et je corrige.
Les causes les plus fréquentes sont listées dans la section 6 du `README.md`.
