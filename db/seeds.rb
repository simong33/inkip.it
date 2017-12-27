# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def valid_date?(dt)
  begin
    Date.parse(dt)
    true
  rescue => e
    false
  end
end


#
# Compute the first and last dates according to the params.
#
# @param  first [String] [First date]
# @param  last [String] [Last date]
#
# @return [Array] [Array include first and last date]
def generate_date_range(first, last)
  first, last = "", first unless last
  if last.nil? || last.empty?
    last = (Time.now - 1.day).in_time_zone('Kolkata').strftime("%Y-%m-%d")
  end
  if first.empty?
    first = Time.strptime(last, "%Y-%m-%d").in_time_zone('Kolkata').beginning_of_month.strftime("%Y-%m-%d")
  end
  (first..last).select { |d|  valid_date?(d) }
end

p "Let's the seeding begin..."

p "Creating people"

1.upto(100) do |n|
  user = User.new
  user.first_name = Faker::DragonBall.character + rand(0..999).to_s
  user.last_name = "FAKE"
  user.email = self.first_name + "@gmail.com",
  user.password = "123456"
  user.save

  book = Book.new(user: user)
  book.title = Faker::Book.title
  book.wordcount = rand(50000..10000)
  book.save

  chapter = Chapter.new(book: book)

  dwc_count = rand(60..120)

  1.upto(dwc_count) do |n|
    DailyWordCount.create!(book: book)
  end
end


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
