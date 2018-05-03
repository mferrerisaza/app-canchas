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
    nit: "8#{Faker::Number.number(8)}",
    bank_name: "Bancolombia",
    bank_account_type: "Ahorros",
    bank_account_number: "#{Faker::Number.number(11)}",
    user: u1
  )
b1.remote_photo_url = "http://elgolazo.co/wp-content/uploads/2015/07/logo-el-golazo-260.png"
b1.save!
sleep(5)  # To avoid Google API Over Query Limit
b2 = Business.new(
    name: "La Jaula Del Angel",
    address: "Centro Comercial El Tesoro Etapa 3 , Piso, Cl. 4, Medellín, Antioquia",
    phone: "444 02 67",
    rating: 4,
    nit: "8#{Faker::Number.number(8)}",
    bank_name: "Bancolombia",
    bank_account_type: "Ahorros",
    bank_account_number: "#{Faker::Number.number(11)}",
    user: u2
  )
b2.remote_photo_url = "https://www.lajauladelangel.com.co/wp-content/uploads/2018/03/Pagina-angel-curvas-1-compressor.jpg"
b2.save!
sleep(5)  # To avoid Google API Over Query Limit
b3 = Business.new(
    name: "El Templo Del Futbol",
    address: "Cra 48, 26sur 87, Envigado, Antioquia",
    phone: "444 40 24",
    rating: 3,
    nit: "8#{Faker::Number.number(8)}",
    bank_name: "Bancolombia",
    bank_account_type: "Ahorros",
    bank_account_number: "#{Faker::Number.number(11)}",
    user: u1
  )
b3.remote_photo_url = "https://scontent.feoh3-1.fna.fbcdn.net/v/t1.0-9/10561777_775640069143792_8736606192136751541_n.jpg?_nc_cat=0&oh=dad78535484de1a3be16e5d8bc2c77a3&oe=5B4F59F5"
b3.save!
sleep(5)  # To avoid Google API Over Query Limit
b4 = Business.new(
    name: "D'Green Zone",
    address: "Cra 27, 23sur 120, Envigado, Antioquia",
    phone: "321 8162860",
    rating: 5,
    nit: "8#{Faker::Number.number(8)}",
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
    name: "Cancha 1",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1520621547148-caeb79466a2b?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6adf1ae9356d789b0fcebc6bd4b2175a&auto=format&fit=crop&w=500&q=60"
f.save!
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 17:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 20:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{(Date.today + 1).to_s} 15:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{(Date.today + 2).to_s} 17:00:00"),
  field: f,
  balance: f.price
  )

f = Field.new(
    name: "Cancha 2",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1473075109809-7a17d327bdf6?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=81e0dd29d94f3aceec5ad4d40b48856a&auto=format&fit=crop&w=500&q=60"
f.save!

b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 8:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 9:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 10:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 11:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 12:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 13:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 14:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 15:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 16:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 17:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 18:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 19:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 20:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 21:00:00"),
  field: f,
  balance: f.price
  )
b = Booking.create!(
  date: DateTime.parse("#{Date.today.to_s} 22:00:00"),
  field: f,
  balance: f.price
  )

f = Field.new(
    name: "Cancha 3",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1505748641491-f7ee2fd6fb4d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=873c7b573c64f8ecf3f8d6cf751ce907&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 4",
    business: b1,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1507226353400-5ec8e43add88?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6cd41ed8c576c3ece63891881e63085e&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 1",
    business: b2,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1503515091255-ab8063a1796d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e24d90f4830afc6ec8dc8870b5d7dee4&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 2",
    business: b2,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1516463439953-eb6a1c2867b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=124c8714d5ed802c34e310600978204a&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 3",
    business: b2,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1495143881214-47a7d7f2e7fa?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6d567157cc727d973da05ec205491c9e&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 4",
    business: b2,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1505843687871-669c89088b12?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b0f9181d7c599c98445be94ac9eef7a6&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 1",
    business: b3,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1504016798967-59a258e9386d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6e57ccfa6c68c13751c23418ba60a80b&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 2",
    business: b3,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1465816676400-e0a480c3ae89?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b53f413711d5dc59bfe1758059b5227a&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 3",
    business: b3,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1509077613385-f89402467146?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=35339ad7ccb62bb2791556f0de25e81f&auto=format&fit=crop&w=282&q=80"
f.save!

f = Field.new(
    name: "Cancha 4",
    business: b3,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1487466365202-1afdb86c764e?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=87c82fa7b9afee7515cc691d6704f902&auto=format&fit=crop&w=752&q=80"
f.save!

f = Field.new(
    name: "Cancha 1",
    business: b4,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1505305976870-c0be1cd39939?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8d14abf1edb104c4705958b4881a70f8&auto=format&fit=crop&w=750&q=80"
f.save!

f = Field.new(
    name: "Cancha 2",
    business: b4,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1497292348804-01ddc743bcb7?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3c9968b01ca6706ec433b1982fc572de&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 3",
    business: b4,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1464983308776-3c7215084895?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=597b71b3ad0c807e2ed5f1cc50439931&auto=format&fit=crop&w=500&q=60"
f.save!

f = Field.new(
    name: "Cancha 4",
    business: b4,
    capacity: (Field::CAPACITY_RANGE).sample,
    price: PRICES.sample.round(-4)
  )
f.remote_photo_url = "https://images.unsplash.com/photo-1516283250450-174387a1af6b?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=025b8c5d162f1d8e3f8d75a29e86cea0&auto=format&fit=crop&w=500&q=60"
f.save!

p "Canchas creadas"

completed = <<-ENDTEXT
                                  ,,   ,  ,,
                                :      ::::,    :::,
                   ,        ,,: :::::::::::::,,  ::::   :  ,
                 ,       ,,,   ,:::::::::::::::::::,  ,:  ,: ,,
            :,        ::,  , , :, ,::::::::::::::::::, :::  ,::::
           :   :    ::,                          ,:::::::: ::, ,::::
          ,     ,:::::                                  :,:::::::,::::,
      ,:     , ,:,,:                                       :::::::::::::
     ::,:   ,,:::,                                          ,::::::::::::,
    ,:::, :,,:::                                               ::::::::::::,
   ,::: :::::::,                                                ,::::::::::::
   :::,,,::::::                                                   ::::::::::::
 ,:::::::::::,                                                     ::::::::::::,
 :::::::::::,                                                      ,::::::::::::
:::::::::::::                    Seeding done                      ,::::::::::::
::::::::::::                                                         ::::::::::::
::::::::::::                                                        ,::::::::::::
:::::::::::,                                                        , :::::::::::
,:::::::::::::,                brought to you by                   ,,::::::::::::
::::::::::::::                                                     ,::::::::::::
 ::::::::::::::,                 Young Maicol                     ,:::::::::::::
 ::::::::::::,                   Young Daniels                   , ::::::::::::
  :,::::::::: ::::                                               :::::::::::::
   ,:::::::::::  ,:                                          ,,:::::::::::::,
     ::::::::::::                                           ,::::::::::::::,
      :::::::::::::::::,                                  ::::::::::::::::
       :::::::::::::::::::,                             ::::::::::::::::
        ::::::::::::::::::::::,                     ,::::,:, , ::::,:::
          :::::::::::::::::::::::,               ::,: ::,::, ,,: ::::
              ,::::::::::::::::::::              ::,,  , ,,  ,::::
                 ,::::::::::::::::              ::,, ,   ,:::,
                      ,::::                         , ,,
                                                  ,,,
ENDTEXT
puts completed

