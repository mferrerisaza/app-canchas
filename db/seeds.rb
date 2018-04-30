p "Empezando..."
p "Creando Usuarios"

u1 = User.new( email: "dan@gmail.com", password:"123456", password_confirmation:"123456", name: "Daniel")
u1.remote_photo_url = "https://scontent.feoh3-1.fna.fbcdn.net/v/t1.0-9/24131196_10155026649428456_9102899353331898211_n.jpg?_nc_cat=0&oh=df2c886a5a654d3482c88b7b0e7eb00c&oe=5B9128E3"
u1.save!

u2 = User.new( email: "mike@gmail.com", password:"123456", password_confirmation:"123456", name: "Miguel")
u2.remote_photo_url = "https://scontent.feoh3-1.fna.fbcdn.net/v/t1.0-9/14955871_10155487411489126_2276472186962218464_n.jpg?_nc_cat=0&oh=853c228a30613060e5ea7c6f88634449&oe=5B632781"
u2.save!

u3 = User.new( email: "emilio@gmail.com", password:"123456", password_confirmation:"123456", name: "Emilio")
u3.remote_photo_url = "https://scontent.feoh3-1.fna.fbcdn.net/v/t1.0-9/23755355_10213244769367989_8483942432704283904_n.jpg?_nc_cat=0&oh=59c86b2cec05d4a7787e4f9acfa8d445&oe=5B5256B4"
u3.save!

u4 = User.new( email: "test@gmail.com", password:"123456", password_confirmation:"123456", name: "Test")
u4.save!
p "Usuarios Creados"

p "Creando Negocios"

b1 = Business.new(
    name: "El Golazo",
    address: "Calle 50, 67 73, Medellín, Antioquia",
    phone: "230 31 48",
    rating: 4,
    nit: "8 #{Faker::Number.number(8)}",
    bank_name: "Bancolombia",
    bank_account_type: "Ahorros",
    bank_account_number: "#{Faker::Number.number(11)}",
    user: u1
  )
b1.remote_photo_url = "http://elgolazo.co/wp-content/uploads/2015/07/logo-el-golazo-260.png"
b1.save!

b2 = Business.new(
    name: "La Jaula Del Angel",
    address: "Centro Comercial El Tesoro Etapa 3 , Piso, Cl. 4, Medellín, Antioquia",
    phone: "444 02 67",
    rating: 4,
    nit: "8 #{Faker::Number.number(8)}",
    bank_name: "Bancolombia",
    bank_account_type: "Ahorros",
    bank_account_number: "#{Faker::Number.number(11)}",
    user: u2
  )
b2.remote_photo_url = "https://www.lajauladelangel.com.co/wp-content/uploads/2018/03/Pagina-angel-curvas-1-compressor.jpg"
b2.save!

b3 = Business.new(
    name: "El Templo Del Futbol",
    address: "Cra 48, 26sur 87, Envigado, Antioquia",
    phone: "444 40 24",
    rating: 3,
    nit: "8 #{Faker::Number.number(8)}",
    bank_name: "Bancolombia",
    bank_account_type: "Ahorros",
    bank_account_number: "#{Faker::Number.number(11)}",
    user: u1
  )
b3.remote_photo_url = "https://scontent.feoh3-1.fna.fbcdn.net/v/t1.0-9/10561777_775640069143792_8736606192136751541_n.jpg?_nc_cat=0&oh=dad78535484de1a3be16e5d8bc2c77a3&oe=5B4F59F5"
b3.save!

b4 = Business.new(
    name: "D'Green Zone",
    address: "Cra 27, 23sur 120, Envigado, Antioquia",
    phone: "321 8162860",
    rating: 5,
    nit: "8 #{Faker::Number.number(8)}",
    bank_name: "Bancolombia",
    bank_account_type: "Ahorros",
    bank_account_number: "#{Faker::Number.number(11)}",
    user: u3
  )
b4.remote_photo_url = "https://scontent.feoh3-1.fna.fbcdn.net/v/t1.0-9/13494929_1559680120995521_7526305646522402494_n.png?_nc_cat=0&oh=7c3a4e9e37fc694127aefc2ce9d8981d&oe=5B59486F"
b4.save!

p "Negocios creados"
p "Creando Canchas"
PRICES = (140000..200000).to_a
f = Field.new(
    name: "Cancha #{b1.fields.size + 1}",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1520621547148-caeb79466a2b?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6adf1ae9356d789b0fcebc6bd4b2175a&auto=format&fit=crop&w=500&q=60"
f.save!
p b1
f = Field.new(
    name: "Cancha #{b1.fields.size + 1}",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1473075109809-7a17d327bdf6?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=81e0dd29d94f3aceec5ad4d40b48856a&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha #{b1.fields.size + 1}",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1505748641491-f7ee2fd6fb4d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=873c7b573c64f8ecf3f8d6cf751ce907&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha #{b1.fields.size + 1}",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1507226353400-5ec8e43add88?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6cd41ed8c576c3ece63891881e63085e&auto=format&fit=crop&w=500&q=60"
f.save!

p "Canchas creadas"


p "Done"
