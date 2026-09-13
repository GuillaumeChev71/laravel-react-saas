# Commandes de développement

## Makefile

Le projet dispose d'un Makefile avec les cibles suivantes :

### Docker (par défaut)

| Cible | Description |
|-------|-------------|
| `make up` | Build et démarre tout (PostgreSQL + app Laravel) |
| `make down` | Arrête tous les conteneurs |
| `make logs` | Suit les logs des conteneurs |
| `make sh` | Ouvre un shell dans le conteneur app |
| `make rebuild` | Rebuild l'image Docker et redémarre |
| `make migrate` | Lance les migrations (conteneur) |
| `make fresh` | `migrate:fresh --seed` (conteneur) |
| `make seed` | Remplit la base avec les seeders (conteneur) |
| `make test` | Lance les tests (conteneur) |
| `make clean` | Nettoie les caches Laravel (conteneur) |

### Local (sans Docker)

| Cible | Description |
|-------|-------------|
| `make help` | Affiche l'aide et la liste des cibles |
| `make install` | `composer install` + `npm install` |
| `make setup` | Installation initiale (.env, clé, migrate, build) |
| `make build` | Build de production du frontend |
| `make back` | Lance le backend (`php artisan serve`) |
| `make front` | Lance le frontend (`npm run dev`) |
| `make dev` | Lance back + front ensemble |

## Artisan

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

## VuePress (cette documentation)

```bash
# Installer les dépendances de la doc
cd docs && npm install

# Lancer le serveur de documentation
make docs
# ou : cd docs && npm run dev

# Builder la doc en statique
make docs-build
```

La documentation est servie sur `http://localhost:8080`.
