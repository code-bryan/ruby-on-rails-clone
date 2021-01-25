route = Framework.route

route.get("/", 'main#index')
route.get("/hola/:name/esto/:hola", 'main#index')
route.get("/hi", 'main#create')
route.post("/hi", 'main#create')
route.put("/hi", 'main#create')
route.delete("/hi", 'main#create')
route.get("/posts", "posts#index")