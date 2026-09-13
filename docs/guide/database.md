# Configuration de la base de données

## Docker (recommandé)

Avec Docker, la base de données PostgreSQL et les migrations sont gérées automatiquement :

```bash
make up        # démarre PostgreSQL + l'app, lance les migrations
make migrate   # relance les migrations dans le conteneur
make fresh     # réinitialise la base + seed (conteneur)
make seed      # remplit la base avec les seeders (conteneur)
```

Les variables de connexion PostgreSQL sont injectées par Docker Compose (`compose.yaml`) et surchargent le `.env` :

```bash
DB_CONNECTION=pgsql
DB_HOST=postgres        # nom du service Docker
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

## Local (sans Docker)

### 1. Configurer les variables d'environnement

Dans le fichier `.env`, configurez les paramètres de connexion PostgreSQL :

```bash
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=laravel
```

### 2. Démarrer PostgreSQL

```bash
docker compose up -d postgres
```

### 3. Exécuter les migrations

```bash
php artisan migrate
```

## Réinitialiser la base

Pour réinitialiser complètement la base de données et exécuter les seeders :

```bash
make fresh
# ou en local : php artisan migrate:fresh --seed
```

::: warning
La commande `migrate:fresh` supprime toutes les tables et les recrée. L'option `--seed` exécute ensuite le `DatabaseSeeder` pour remplir la base avec des données initiales ou de test.
:::

## Seeders

Le fichier `DatabaseSeeder` est le point central pour remplir votre base de données avec des données initiales ou de test. Il se trouve dans `database/seeders/DatabaseSeeder.php`.

```bash
make seed
# ou en local : php artisan db:seed
```
