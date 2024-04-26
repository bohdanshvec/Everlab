Admin.create!(email: 'dan@ukr.net', password: 'dan', password_confirmation: 'dan' ) unless Admin.where(email: 'dan@ukr.net').present?

30.times do |count|
  title = Faker::Book.title
  body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
  position = count
  Product.create(title: title, body: body, position: position)
end
