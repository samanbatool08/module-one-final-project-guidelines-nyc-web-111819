User.destroy_all
Restaurant.destroy_all
Review.destroy_all

User.create(username: "NYnotafoodie")
User.create(username: "Chocococo")
# User.create(username: Faker::Name.first)

Restaurant.create(name: "Chipotle", cuisine: "Mexican")
Restaurant.create(name: "Addys BBQ", cuisine: "American")
Restaurant.create(name: "Wo Hop", cuisine: "Chinese")
Restaurant.create(name: "Shanghai", cuisine: "Chinese")
Restaurant.create(name: "Pisillo Italian Panini", cuisine: "Italian")
Restaurant.create(name: "Rubirosa", cuisine: "Italian")
Restaurant.create(name: "Lupa", cuisine: "Italian")
Restaurant.create(name: "Pampano", cuisine: "Mexican")
Restaurant.create(name: "Tacuba", cuisine: "Mexican")
Restaurant.create(name: "Arriba Arriba Midtown", cuisine: "Mexican")
Restaurant.create(name: "Urban Tandoor", cuisine: "Indian")
Restaurant.create(name: "Tamarind", cuisine: "Indian")
Restaurant.create(name: "Masala Times Greenwich Village", cuisine: "Indian")
Restaurant.create(name: "Thelewala", cuisine: "Indian")
Restaurant.create(name: "Kubeh", cuisine: "Middle Eastern")
Restaurant.create(name: "Baba Ghanouge", cuisine: "Middle Eastern")
Restaurant.create(name: "The Dutch", cuisine: "American")
Restaurant.create(name: "ABC Kitchen", cuisine: "American")

