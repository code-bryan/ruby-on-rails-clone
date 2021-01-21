routes = Framework.routes

routes.get("/", 'main#index')
routes.post("/hi", 'main#create')
routes.put("/hi", 'main#create')
routes.delete("/hi", 'main#create')
routes.get("/posts", "posts#index")