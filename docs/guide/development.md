# Démarrage de l'application

## Option 1 : Docker (recommandé)

Le projet est entièrement dockerisé. Une seule commande build et démarre tout (PostgreSQL + app Laravel) :

```bash
make up
```

L'entrypoint du conteneur installe automatiquement les dépendances (Composer + npm), build les assets Vite, génère la clé applicative, attend PostgreSQL et lance les migrations.

L'application est accessible sur `http://localhost:8000`.

::: tip Premier démarrage
Le premier `make up` prend 1 à 2 minutes (téléchargement des dépendances, build Vite). Les démarrages suivants sont beaucoup plus rapides grâce aux volumes nommés.
:::

Suivre les logs :

```bash
make logs
```

Arrêter les conteneurs :

```bash
make down
```

## Option 2 : Local (sans Docker)

Nécessite PHP, Composer et Node installés localement.

### Backend + frontend ensemble

```bash
make dev
```

Cette commande lance en parallèle, via `composer dev` (concurrently) :
- le serveur Laravel (`php artisan serve`)
- la queue (`php artisan queue:listen`)
- les logs Pail
- le serveur de développement Vite

### Séparément

```bash
make back    # backend seul (php artisan serve)
make front   # frontend seul (Vite HMR)
```

::: warning
Si vous utilisez Docker ET le mode local en parallèle, le Vite dev server local crée un fichier `public/hot` qui force Laravel à pointer vers le dev server au lieu des assets buildés. Stoppez le Vite local avant de lancer le conteneur Docker.
:::
