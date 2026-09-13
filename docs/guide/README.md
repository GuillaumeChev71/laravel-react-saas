# Introduction

Application SaaS construite avec **Laravel 12** et **React** (Inertia.js).

Cette documentation décrit l'installation, la configuration et les commandes de développement du projet.

## Démarrage rapide

```bash
# 1. Dépendances
composer install
npm install

# 2. Base de données (PostgreSQL via Docker)
docker compose up -d

# 3. Configuration
cp .env.example .env
php artisan key:generate
php artisan migrate

# 4. Lancer le projet
make dev
```

Le backend sera accessible sur `http://localhost:8000`.

## Liens utiles

- [Guide d'installation](/guide/installation)
- [Configuration de la base de données](/guide/database)
- [Démarrage de l'application](/guide/development)
- [Commandes de développement](/guide/commands)
