route = Framework.route

route.get("/", 'main#index')
route.post("/hi", 'main#create')
route.put("/hi", 'main#create')
route.delete("/hi", 'main#create')
route.get("/posts", "posts#index")