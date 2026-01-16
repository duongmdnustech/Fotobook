# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user1 = User.create(lname: "Honda", fname: "Yakuza", email: "honda.yz@example.com", password: "12345678",role: "admin")
user2 = User.create(lname: "Bruce", fname: "John", email: "jbruce@example.com", password: "12345678", role: "user")
user3 = User.create(lname: "de Havana", fname: "Johnathan", email: "deHav.john@example.com", password: "12345678", role: "user")
user4 = User.create(lname: "Richardson", fname: "Kelvin", email: "kel.rich@example.com", password: "12345678", role: "user")
user5 = User.create(lname: "Hamilton", fname: "Colin", email: "hal.colin@example.com", password: "12345678", role: "user")

gmt7 = Time.now.getlocal("+07:00")
album1 = Album.create(title: "Nature Collection", description: "A collection of beautiful nature photographs.", public_at: nil, created_at: Time.now.getlocal("+07:00"), status: true, user_id: user1.uid)
album2 = Album.create(title: "Urban Exploration", description: "Exploring the hidden gems of the city.", public_at: nil, created_at: Time.now.getlocal("+07:00"), status: true, user_id: user2.uid)
album3 = Album.create(title: "Wildlife Wonders", description: "Capturing the beauty of wildlife in their natural habitat.", public_at: nil, created_at: Time.now.getlocal("+07:00"), status: true, user_id: user3.uid)
album4 = Album.create(title: "Travel Diaries", description: "Memories from various travel adventures around the world.", public_at: nil, created_at: Time.now.getlocal("+07:00"), status: true, user_id: user4.uid)
Album.where(status: true, public_at: nil).find_each do |photo|
  photo.update!(public_at: gmt7)
end

Photo.create(title: "Fall in Minesota", description: "A beautiful fall scenery in Minnesota.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: false, url: "", user_id: user2.uid)

# 5 with status: true
Photo.create(title: "Autumn Lake", description: "Crisp morning by the lake.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: true, url: "", user_id: user2.uid)
Photo.create(title: "City Lights", description: "Night skyline illuminated.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: true, url: "", user_id: user2.uid, album_id: album2.album_id)
Photo.create(title: "Desert Dunes", description: "Waves of golden sand at sunset.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: true, url: "", user_id: user4.uid, album_id: album4.album_id)
Photo.create(title: "Mountain Peaks", description: "Snow-capped mountains under clear sky.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: true, url: "", user_id: user4.uid, album_id: album4.album_id)
Photo.create(title: "Forest Path", description: "Sunlight filtering through tall pines.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: true, url: "", user_id: user2.uid, album_id: nil)

Photo.where(status: true, public_at: nil).find_each do |photo|
  photo.update!(public_at: gmt7)
end
# 5 with status: false
Photo.create(title: "Spring Blossoms", description: "Cherry blossoms in full bloom.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: false, url: "", user_id: user3.uid, album_id: album1.album_id)
Photo.create(title: "Beach Sunset", description: "Sun setting over calm ocean.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: false, url: "", user_id: user4.uid, album_id: album4.album_id)
Photo.create(title: "Old Barn", description: "Rustic barn surrounded by fields.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: false, url: "", user_id: user5.uid, album_id: nil)
Photo.create(title: "Rainy Street", description: "Wet pavement reflecting neon signs.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: false, url: "", user_id: user2.uid, album_id: album2.album_id)
Photo.create(title: "Hidden Waterfall", description: "A secluded waterfall in the woods.", public_at: nil, upload_at: Time.now.getlocal("+07:00"), status: false, url: "", user_id: user1.uid, album_id: album1.album_id)
puts "Total Photos: #{Photo.count}, Public Photos: #{Photo.where(status: true).count}, Private Photos: #{Photo.where(status: false).count}"


Following.create(follower_id: user2.uid, following_id: user1.uid)
Following.create(follower_id: user3.uid, following_id: user1.uid)
Following.create(follower_id: user4.uid, following_id: user1.uid)
Following.create(follower_id: user5.uid, following_id: user1.uid)
Following.create(follower_id: user3.uid, following_id: user2.uid)
Following.create(follower_id: user4.uid, following_id: user2.uid)
Following.create(follower_id: user5.uid, following_id: user2.uid)