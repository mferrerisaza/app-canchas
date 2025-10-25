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
b2.save!
p "Creando Canchas el Templo"

f = Field.new(
    name: "Cancha 1",
    business: b2,
    capacity: 12,
    price: 198000
  )
f.save!
f = Field.new(
    name: "Cancha 2",
    business: b2,
    capacity: 12,
    price: 198000
  )
f.remote_photo_url = "https://res.cloudinary.com/djlocq70e/image/upload/v1527552309/WhatsApp_Image_2018-05-28_at_6.53.15_PM.jpg"
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
