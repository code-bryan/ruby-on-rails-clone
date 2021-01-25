route = Framework.route

route.get("/", 'main#index')
route.get("/hola/:name/esto/:hola/:prueba", 'main#hola')
route.get("/hi", 'main#create')
route.post("/hi", 'main#create')
route.put("/hi", 'main#create')
route.delete("/hi", 'main#create')

# post routes
route.get("/posts", "posts#index")
route.get("/posts/:id", "posts#show")

# test
route.get("/test", ->() do
  @test = "Hola"
  @arr = %w(one two three)
  Http::Response.view("main.index", binding)
end)