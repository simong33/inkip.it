# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# def valid_date?(dt)
#   begin
#     Date.parse(dt)
#     true
#   rescue => e
#     false
#   end
# end


#
# Compute the first and last dates according to the params.
#
# @param  first [String] [First date]
# @param  last [String] [Last date]
#
# @return [Array] [Array include first and last date]
# def generate_date_range(first, last)
#   first, last = "", first unless last
#   if last.nil? || last.empty?
#     last = (Time.now - 1.day).in_time_zone('Kolkata').strftime("%Y-%m-%d")
#   end
#   if first.empty?
#     first = Time.strptime(last, "%Y-%m-%d").in_time_zone('Kolkata').beginning_of_month.strftime("%Y-%m-%d")
#   end
#   (first..last).select { |d|  valid_date?(d) }
# end

# 1.upto(100) do |n|
#   user = User.new
#   user.first_name = Faker::DragonBall.character + rand(0..999).to_s
#   user.last_name = "FAKE"
#   user.email = self.first_name + "@gmail.com",
#   user.password = "123456"
#   user.save

#   book = Book.new(user: user)
#   book.title = Faker::Book.title
#   book.wordcount = rand(50000..10000)
#   book.save

#   chapter = Chapter.new(book: book)

#   dwc_count = rand(60..120)

#   1.upto(dwc_count) do |n|
#     DailyWordCount.create!(book: book)
#   end
# end


# p "Creating 8 books"

# 1.upto(8) do |n|
#   Book.create!(
#     title: Faker::Book.title,
#     genre: Faker::Book.genre,
#     user: User.all.last,
#     word_goal: rand(10000..100000),
#     created_at: generate_date_range("2017-01-01", "2017-12-15")
#     )
# end

# p "Creating 100 chapters"

# 1.upto(100) do |n|
#   Chapter.create!(
#     title: Faker::Fallout.quote,
#     content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. In distinctio harum, necessitatibus error alias. Ea quod mollitia fuga laborum nemo nisi quam reiciendis sapiente culpa quae vitae itaque, alias dolore.",
#     book: Book.all.last(8).sample
#     )
# end

# p "Creating 300 characters"

# 1.upto(300) do |n|
#   Character.create!(
#     first_name: Faker::RickAndMorty.character,
#     book: Book.all.last(8).sample
#     )
# end

# p "Creating 200 places"

# 1.upto(200) do |n|
#   Place.create!(
#     name: Faker::Zelda.location,
#     book: Book.all.last(8).sample
#     )
# end

# p "Creating 500 streaks"

# 1.upto(500) do |n|
#   Streak.create!(
#     book: Book.all.last(8).sample,
#     created_at: generate_date_range(self.book.created_at, "2017-12-15")
#     )
# end

# p "Creating 500 DWC"

# 1.upto(500) do |n|
#   DailyWordCount.create!(
#     book: Book.all.last(8).sample,
#     wordcount: rand(100..5000),
#     total_word_count: rand(100..5000),
#     created_at: generate_date_range(self.book.created_at, "2017-12-15")
#     )
# end

p "Let's the seeding begin..."

p "Creating people"

sango = User.new
sango.user_name = "Sango"
sango.email = "sango@gmail.com"
sango.password = "sango123"
sango.save

thomasb = User.new
thomasb.user_name = "Thomas75"
thomasb.email = "thomas@gmail.com"
thomasb.password = "thomasb123"
thomasb.save

sophiec = User.new
sophiec.user_name = "Sophie E."
sophiec.email = "sophie@gmail.com"
sophiec.password = "sophiec123"
sophiec.save

oradour = User.new
oradour.user_name = "Oradille"
oradour.email = "oradour@gmail.com"
oradour.password = "oradille123"
oradour.save

gigamesh = User.new
gigamesh.user_name = "Gigamesh"
gigamesh.email = "gigamesh@gmail.com"
gigamesh.password = "gigamesh123"
gigamesh.save

aglae = User.new
aglae.user_name = "Aglae"
aglae.email = "aglae@gmail.com"
aglae.password = "aglae123"
aglae.save

nenuphar = User.new
nenuphar.user_name = "nenuphar"
nenuphar.email = "nenuphar@gmail.com"
nenuphar.password = "nenuphar123"
nenuphar.save

jolly_coeur = User.new
jolly_coeur.user_name = "jolly_coeur"
jolly_coeur.email = "jolly_coeur@gmail.com"
jolly_coeur.password = "jolly_coeur123"
jolly_coeur.save

elza = User.new
elza.user_name = "elza"
elza.email = "elza@gmail.com"
elza.password = "elza123"
elza.save

domino = User.new
domino.user_name = "domino"
domino.email = "domino@gmail.com"
domino.password = "domino123"
domino.save

p "Create their books"

b1 = Book.new(user: sango)
b1.title = "Les Hautes Montagnes"
b1.max_streaks = 33
b1.save

b2 = Book.new(user: thomasb)
b2.title = "Viens me voir"
b2.max_streaks = 27
b2.max_daily_wordcount = 4533
b2.save

b3 = Book.new(user: sophiec)
b3.title = "Plus loin les rêves"
b3.max_streaks = 25
b3.max_daily_wordcount = 5410
b3.save

b4 = Book.new(user: oradour)
b4.title = "Demain trop loin"
b4.max_streaks = 25
b4.max_daily_wordcount = 2109
b4.save

b5 = Book.new(user: gigamesh)
b5.title = "Trozorus"
b5.max_streaks = 19
b5.max_daily_wordcount = 2566
b5.save

b6 = Book.new(user: aglae)
b6.title = "Pardon"
b6.max_streaks = 19
b6.max_daily_wordcount = 3147
b6.save

b7 = Book.new(user: nenuphar)
b7.title = "Nenu le Trogloïde"
b7.max_streaks = 15
b7.max_daily_wordcount = 4598
b7.save

b8 = Book.new(user: jolly_coeur)
b8.title = "Ola 19"
b8.max_streaks = 14
b8.max_daily_wordcount = 2599
b8.save

b9 = Book.new(user: elza)
b9.title = "Stop it"
b9.max_streaks = 12
b9.max_daily_wordcount = 9521
b9.save

b10 = Book.new(user: domino)
b10.title = "Domino et ses frères"
b10.max_streaks = 12
b10.max_daily_wordcount = 1987
b10.save

p "Create 100 chapters"

1.upto(100) do |n|
  content = "je suis " * rand(1700..2456)
  Chapter.create!(
    book: Book.all.last(10).sample,
    content: content
    )
end

p "Create 500 DWC"

1.upto(500) do |n|
  DailyWordCount.create!(
    book: Book.all.last(10).sample,
    wordcount: rand(100..2000),
    )
end

b1.max_daily_wordcount = rand(2500..6000)
b2.max_daily_wordcount = rand(2500..6000)
b3.max_daily_wordcount = rand(2500..6000)
b4.max_daily_wordcount = rand(2500..6000)
b5.max_daily_wordcount = rand(2500..6000)
b6.max_daily_wordcount = rand(2500..6000)
b7.max_daily_wordcount = rand(2500..6000)
b8.max_daily_wordcount = rand(2500..6000)
b9.max_daily_wordcount = rand(2500..6000)
b10.max_daily_wordcount = rand(2500..6000)

b1.save
b2.save
b3.save
b4.save
b5.save
b6.save
b7.save
b8.save
b9.save
b10.save
