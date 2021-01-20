routes = Fromework.routes

routes.get("/", 'main#index')
routes.get("/posts", "posts#index")