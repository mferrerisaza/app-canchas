p "Empezando..."
p "Creando Usuarios"

u1 = User.find(1)

p "Usuarios Creados"

p "Creando Señor Gol"

b1 = Business.new(
    name: "Señor Gol",
    address: "Cra. 48 #26 Sur - 211, Envigado, Antioquia",
    phone: "332 44 33",
    rating: 5,
    opening: 18,
    closing: 21,
    user: u1
  )
b1.remote_photo_url = "https://civica.metrodemedellin.gov.co/portals/0/Images/Enterate/entretenimiento/senorGol.jpg"
b1.save!
p "Creando Canchas Señor Gol"

f = Field.new(
    name: "Cancha 1",
    business: b1,
    capacity: 14,
    price: 195000
  )
f.remote_photo_url = "https://res.cloudinary.com/djlocq70e/image/upload/v1527550103/cancha1.jpg"
f.save!
f = Field.new(
    name: "Cancha 2",
    business: b1,
    capacity: 14,
    price: 195000
  )
f.remote_photo_url = "https://res.cloudinary.com/djlocq70e/image/upload/v1527550113/cancha2.jpg"
f.save!
f = Field.new(
    name: "Cancha 3",
    business: b1,
    capacity: 14,
    price: 195000
  )
f.remote_photo_url = "https://res.cloudinary.com/djlocq70e/image/upload/v1527550126/cancha3.jpg"
f.save!
f = Field.new(
    name: "Cancha 4",
    business: b1,
    capacity: 14,
    price: 195000
  )
f.save!
f = Field.new(
    name: "Cancha 5",
    business: b1,
    capacity: 14,
    price: 195000
  )
f.remote_photo_url = "https://res.cloudinary.com/djlocq70e/image/upload/v1527550131/cancha5.jpg"
f.save!

sleep(5)  # To avoid Google API Over Query Limit
p "Creando el Templo"

b2 = Business.new(
    name: "El Templo Del Fútbol",
    address: "Carrera 48 #26 Sur-67 a 26 Sur-141, Envigado, Antioquia, Colombia",
    phone: "444 40 24",
    rating: 5,
    opening: 18,
    closing: 22,
    user: u1
  )
b2.remote_photo_url = "https://scontent.feoh1-1.fna.fbcdn.net/v/t1.0-9/10491096_775640365810429_2839286778075084990_n.jpg?_nc_cat=0&_nc_eui2=AeH020PB-hiinkmCMgN1g61UqQlmQE6_bn73q9e3_gfYDJME_Z5XOClBgry-_qxuDXfLITG60jBlVlXV9Y2Dc8gxsrMYeju8oMFwSJ8vFdCycw&oh=a9aa110ef1b3e5e48a0a379eff54f817&oe=5BC4BE39"
b2.save!
p "Creando Canchas el Templo"

f = Field.new(
    name: "Cancha 1",
    business: b2,
    capacity: 12,
    price: 198000
  )
f.remote_photo_url = "https://scontent.feoh1-1.fna.fbcdn.net/v/t1.0-9/602654_414257161948753_254151712_n.jpg?_nc_cat=0&_nc_eui2=AeGslW1Rkf4u7RqvFQ6BNHgJ9MdChrWwy49g2gd7PC3S3KPUpWzhnOlBxyoBvWGJ5u0VABcp1cW2-Dh2ifKb3YRrTf-rNyXg9TiEu9nWKLERFw&oh=71556f7c7c4d80ce5999065ddda2c806&oe=5BBF4695"
f.save!
f = Field.new(
    name: "Cancha 2",
    business: b2,
    capacity: 12,
    price: 198000
  )
f.remote_photo_url = "http://res.cloudinary.com/djlocq70e/image/upload/v1527552309/WhatsApp_Image_2018-05-28_at_6.53.15_PM.jpg"
f.save!
f = Field.new(
    name: "Cancha Rápida",
    business: b2,
    capacity: 16,
    price: 198000
  )
f.save!

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
