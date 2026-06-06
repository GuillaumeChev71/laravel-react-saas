# Laravel React SaaS

Application SaaS construite avec Laravel 11 et React (Inertia.js).

## 📋 Table des matières

- [Stack Technique](#stack-technique)
- [Installation depuis zéro](#installation-depuis-zéro)
- [Installation du projet existant](#installation-du-projet-existant)
- [Configuration de la base de données](#configuration-de-la-base-de-données)
- [Démarrage de l'application](#démarrage-de-lapplication)
- [Commandes de développement](#commandes-de-développement)
- [Ressources](#ressources)

## 🛠️ Stack Technique

- **Backend**: Laravel 11
- **Frontend**: React avec Inertia.js
- **Authentification**: Laravel Breeze
- **Base de données**: PostgreSQL
- **Containerisation**: Docker
- **Styling**: Tailwind CSS
- **Icons**: [Feather Icons](https://feathericons.com/)

## 🚀 Installation depuis zéro

> **Note**: Ces étapes sont uniquement nécessaires pour créer un nouveau projet. Si vous clonez ce projet existant, passez à la section [Installation du projet existant](#installation-du-projet-existant).

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

## 📦 Installation du projet existant

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

## 🗄️ Configuration de la base de données

### 1. Configurer les variables d'environnement

Dans le fichier `.env`, configurez les paramètres de connexion PostgreSQL :

```php
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

### 2. Démarrer PostgreSQL avec Docker

Si vous n'avez pas encore lancé le conteneur Docker :

```bash
docker compose up -d postgres
```

### 3. Exécuter les migrations

```bash
php artisan migrate
```

Pour réinitialiser complètement la base de données et exécuter les seeders :

```bash
php artisan migrate:fresh --seed
```

> **Note**: La commande `migrate:fresh` supprime toutes les tables et les recrée. L'option `--seed` exécute ensuite le `DatabaseSeeder` pour remplir la base avec des données initiales ou de test.

## ▶️ Démarrage de l'application

Vous devez lancer deux serveurs séparément :

### Backend (Laravel)

```bash
php artisan serve
```

Le backend sera accessible sur `http://localhost:8000`

### Frontend (Vite)

```bash
npm run dev
```

Le serveur de développement Vite compilera vos assets React.

## 🔧 Commandes de développement

### Créer un Model

Les models représentent vos tables de base de données et permettent d'interagir avec elles via Eloquent ORM.

```bash
php artisan make:model NomModel -m
```

L'option `-m` crée automatiquement une migration associée au model.

### Créer un Observer

Un **Observer** est une classe qui permet d'observer les événements d'un modèle Eloquent et d'exécuter du code automatiquement quand ces événements se produisent.

```bash
php artisan make:observer UserObserver
```

**Utilité** : Un observer agit comme un écouteur (listener) pour les actions sur un modèle :
- `created` - quand une entrée est créée
- `updated` - quand une entrée est mise à jour
- `deleted` - quand une entrée est supprimée
- `restored` - quand une entrée supprimée est restaurée
- `saved` - quand une entrée est enregistrée
- etc.

Cela permet de centraliser la logique liée à un modèle sans surcharger le modèle lui-même.

### Créer un Controller

Les controllers contiennent la logique de votre application (traitement des requêtes, validation, etc.).

```bash
php artisan make:controller Feature1Controller
```

### Créer une Resource

Les Resources permettent de transformer vos modèles en format JSON pour les réponses API.

```bash
php artisan make:resource UserResource
```

### Database Seeder

Le fichier `DatabaseSeeder` est le point central pour remplir votre base de données avec des données initiales ou de test. Il se trouve dans `database/seeders/DatabaseSeeder.php`.

Pour exécuter les seeders :

```bash
php artisan db:seed
```

## 📚 Ressources

- [Documentation Laravel](https://laravel.com/docs)
- [Documentation Inertia.js](https://inertiajs.com/)
- [Documentation React](https://react.dev/)
- [Feather Icons](https://feathericons.com/)
- [Tailwind CSS](https://tailwindcss.com/)

## 📄 License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
