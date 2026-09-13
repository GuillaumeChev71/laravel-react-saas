export const redirects = JSON.parse("{}")

export const routes = Object.fromEntries([
  ["/", { loader: () => import(/* webpackChunkName: "index.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/README.md"), meta: {"title":"Laravel React SaaS"} }],
  ["/guide/commands.html", { loader: () => import(/* webpackChunkName: "guide_commands.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/guide/commands.md"), meta: {"title":"Commandes de développement"} }],
  ["/guide/database.html", { loader: () => import(/* webpackChunkName: "guide_database.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/guide/database.md"), meta: {"title":"Configuration de la base de données"} }],
  ["/guide/development.html", { loader: () => import(/* webpackChunkName: "guide_development.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/guide/development.md"), meta: {"title":"Démarrage de l'application"} }],
  ["/guide/installation.html", { loader: () => import(/* webpackChunkName: "guide_installation.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/guide/installation.md"), meta: {"title":"Installation"} }],
  ["/guide/", { loader: () => import(/* webpackChunkName: "guide_index.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/guide/README.md"), meta: {"title":"Introduction"} }],
  ["/guide/stack.html", { loader: () => import(/* webpackChunkName: "guide_stack.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/guide/stack.md"), meta: {"title":"Stack Technique"} }],
  ["/404.html", { loader: () => import(/* webpackChunkName: "404.html" */"C:/Users/33781/Desktop/laravel-react-saas/docs/.vuepress/.temp/pages/404.html.vue"), meta: {"title":""} }],
]);
