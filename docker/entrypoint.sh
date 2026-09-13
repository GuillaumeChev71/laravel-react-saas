#!/bin/sh
set -e

echo "==> Préparation de l'environnement..."
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Force les variables DB du .env avec les valeurs Docker (le .env du host
# peut contenir DB_HOST=127.0.0.1 qui est invalide dans le conteneur).
set_env_var() {
    key="$1"
    val="$2"
    # Supprime la ligne existante (commentée ou non) puis ajoute la bonne valeur.
    sed -i "/^${key}=/d" .env
    echo "${key}=${val}" >> .env
}
set_env_var DB_CONNECTION "${DB_CONNECTION:-pgsql}"
set_env_var DB_HOST "${DB_HOST:-postgres}"
set_env_var DB_PORT "${DB_PORT:-5432}"
set_env_var DB_DATABASE "${DB_DATABASE:-laravel}"
set_env_var DB_USERNAME "${DB_USERNAME:-laravel}"
set_env_var DB_PASSWORD "${DB_PASSWORD:-laravel}"

mkdir -p storage/framework/{cache,sessions,views} storage/logs bootstrap/cache
chmod -R 775 storage bootstrap/cache

echo "==> Installation des dépendances PHP..."
composer install --no-interaction

echo "==> Installation des dépendances Node..."
npm install

echo "==> Build des assets frontend..."
npm run build

# On supprime le fichier "hot" laissé par un éventuel "npm run dev" local
# pour que Laravel serve les assets buildés via le manifest Vite.
rm -f public/hot

echo "==> Génération de la clé applicative..."
php artisan key:generate

echo "==> Attente de PostgreSQL..."
max_tries=30
try=0
until php -r "new PDO('pgsql:host=${DB_HOST};port=${DB_PORT};dbname=${DB_DATABASE}', '${DB_USERNAME}', '${DB_PASSWORD}');" 2>/dev/null; do
    try=$((try + 1))
    if [ $try -ge $max_tries ]; then
        echo "ERREUR: impossible de se connecter à PostgreSQL après ${max_tries} tentatives."
        exit 1
    fi
    echo "    PostgreSQL non prêt (tentative ${try}/${max_tries})..."
    sleep 1
done
echo "    PostgreSQL est prêt."

echo "==> Exécution des migrations..."
php artisan migrate --force

echo "==> Démarrage du serveur Laravel sur le port 8000..."
exec php artisan serve --host=0.0.0.0 --port=8000
