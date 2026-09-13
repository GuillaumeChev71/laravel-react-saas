# Installation

## Installation du projet existant

Si vous clonez ce projet, suivez ces étapes :

### 1. Installer les dépendances

```bash
# Dépendances PHP
composer install

# Dépendances JavaScript
npm install
```

### 2. Configuration de l'environnement

Dupliquer le fichier `.env.example` et le renommer en `.env` :

```bash
cp .env.example .env
```

### 3. Générer la clé de l'application

```bash
php artisan key:generate
```

::: tip Raccourci
La commande `make setup` effectue toutes ces étapes d'un coup (sauf les dépendances `composer`/`npm`).
:::

## Installation depuis zéro

::: warning
Ces étapes sont uniquement nécessaires pour créer un nouveau projet. Si vous clonez ce projet existant, passez à la section ci-dessus.
:::

### 1. Créer le projet Laravel

```bash
composer create-project laravel/laravel laravel-react-saas
cd laravel-react-saas
```

### 2. Installer Laravel Breeze

**Laravel Breeze** fournit une implémentation minimaliste de toutes les fonctionnalités d'authentification de Laravel (connexion, inscription, réinitialisation de mot de passe, etc.).

```bash
composer require laravel/breeze --dev
php artisan breeze:install
```

Lors de l'installation de Breeze, sélectionnez **React** comme stack frontend et **Inertia** comme adaptateur.
