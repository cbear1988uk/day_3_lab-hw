require('pry')
require_relative('../models/album')
require_relative('../models/artist')

artist1 = Artist.new({'name' => 'Holy Fawn'})
artist2 = Artist.new({'name' => 'Autumn Creatures'})
artist3 = Artist.new({'name' => 'Thrice'})
artist1.save()
artist2.save()
artist3.save()


album1 = Album.new({'name' => 'Death Spells', 'genre' => 'Drone'})
album2 = Album.new({'name' => 'Funeral Garden', 'genre' => 'Post-Rock'})
album3 = Album.new({'name' => ['The Alchemy Index', 'Beggars', 'Vheissu'], 'genre' => 'Alternative'})
album1.save()
album2.save()
album3.save()

binding.pry
nil
