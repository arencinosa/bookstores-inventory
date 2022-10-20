# dummy data for playing around

[
    'Once upon a time',
    'The Wizard of Oz',
    'Twenty Thousand Leagues Under the Sea',
    'Das Kapital',
    'Ender\'s game'
].each do |n|
    Book.create!(name: n)
end

[
    'Books & More',
    'Jimmy\'s',
    'Neverending tale',
    'Read & Write',
    'County\'s bookstore'
].each do |n|
    Bookstore.create!(name: n)
end

Bookstore.all.each do |bookstore|
    Book.all.sample(rand(2..Book.count)).each do |book|
        Stock.create!(book: book, bookstore: bookstore, stock_level: rand(20))
    end
end