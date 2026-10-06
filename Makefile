.PHONY: help up up-build down logs sh rebuild install setup migrate fresh seed test build clean back front dev docs docs-install docs-build docs-clean audit audit-back audit-front format format-back format-front

# Permet d'utiliser '>' au lieu d'une tabulation pour les recettes
# (évite les problèmes de tabulations sous Windows / Git Bash).
.RECIPEPREFIX = >

# Variables configurables
DC       = docker compose
EXEC     = $(DC) exec app
PHP      = php
COMPOSER = composer
NPM      = npm
ARTISAN  = $(PHP) artisan
HOST     = 127.0.0.1
PORT     = 8000

help: ## Affiche cette aide
>@echo "Usage: make <cible>"
>@echo ""
>@echo "Cibles disponibles :"
>@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

# ---- Docker : démarrage / arrêt ----

up: ## Build et démarre tout le projet (PostgreSQL + app Laravel)
>$(DC) up -d --build

up-build: ## Build l'image Docker, démarre les conteneurs et build le frontend
>$(DC) up -d --build
>$(NPM) run build

down: ## Arrête tous les conteneurs
>$(DC) down

logs: ## Suit les logs des conteneurs (Ctrl+C pour quitter)
>$(DC) logs -f

sh: ## Ouvre un shell dans le conteneur app
>$(EXEC) sh

rebuild: ## Rebuild l'image Docker et redémarre
>$(DC) up -d --build --force-recreate

# ---- Artisan (dans le conteneur) ----

migrate: ## Lance les migrations (conteneur)
>$(EXEC) php artisan migrate

fresh: ## Réinitialise la base + seed (conteneur)
>$(EXEC) php artisan migrate:fresh --seed

seed: ## Remplit la base avec les seeders (conteneur)
>$(EXEC) php artisan db:seed

test: ## Lance les tests (conteneur)
>$(EXEC) php artisan test

clean: ## Nettoie les caches Laravel (conteneur)
>$(EXEC) php artisan optimize:clear

# ---- Local (sans Docker) ----
# Ces cibles nécessitent PHP, Composer et Node installés localement.

install: ## [local] Installe les dépendances (composer + npm)
>$(COMPOSER) install
>$(NPM) install

setup: ## [local] Installation initiale (.env, clé, migrate, build)
>[ -f .env ] || cp .env.example .env
>$(ARTISAN) key:generate
>$(ARTISAN) migrate --force
>$(NPM) install
>$(NPM) run build

build: ## [local] Build de production du frontend
>$(NPM) run build

back: ## [local] Lance uniquement le backend (php artisan serve)
>$(ARTISAN) serve --host=$(HOST) --port=$(PORT)

front: ## [local] Lance uniquement le frontend (Vite HMR)
>$(NPM) run dev

dev: ## [local] Lance backend + frontend ensemble (composer dev)
>$(COMPOSER) dev

# ---- Audit des dépendances (local) ----

audit: ## [local] Dépendances + vulnérabilités back (PHP) et front (JS)
>@$(MAKE) --no-print-directory -k audit-back audit-front

audit-back: ## [local] Dépendances et vulnérabilités du backend (Composer)
>@echo "=== Dépendances directes backend (composer show) ==="
>$(COMPOSER) show --direct
>@echo ""
>@echo "=== Vulnérabilités backend (composer audit) ==="
>$(COMPOSER) audit

audit-front: ## [local] Dépendances et vulnérabilités du frontend (npm)
>@echo "=== Dépendances directes frontend (npm list) ==="
>$(NPM) list --depth=0
>@echo ""
>@echo "=== Vulnérabilités frontend (npm audit) ==="
>$(NPM) audit

# ---- Formatage du code (local) ----

# Pint : lance le wrapper .bat sous Windows (cmd.exe ne sait pas
# exécuter le script shell vendor/bin/pint), le script normal ailleurs.
ifeq ($(OS),Windows_NT)
PINT = vendor\bin\pint.bat
else
PINT = vendor/bin/pint
endif

format: ## [local] Formate le backend (Pint) et le frontend (Prettier)
>@$(MAKE) --no-print-directory -k format-back format-front

format-back: ## [local] Formate le backend avec Pint
>$(PINT)

format-front: ## [local] Formate le frontend avec Prettier
>$(NPM) run format

# ---- Documentation VuePress (local) ----

DOCS_DIR = docs

docs-install: ## Installe les dépendances de la documentation VuePress
>cd $(DOCS_DIR) && $(NPM) install

docs: ## Lance le serveur de documentation VuePress (http://localhost:8080)
>cd $(DOCS_DIR) && $(NPM) run dev

docs-build: ## Build la documentation en statique
>cd $(DOCS_DIR) && $(NPM) run build

docs-clean: ## Nettoie les artefacts de build de la documentation
>cd $(DOCS_DIR) && rm -rf .vuepress/dist .vuepress/cache node_modules
