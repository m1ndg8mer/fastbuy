admin = User.new(email: 'admin@gmail.com', password: '123456')
admin.add_role :admin
admin.save

Category.create!(title: 'Mobile Phones')
Category.create!(title: 'Nokia', parent_id: Category.first.id)
Product.create!(title: 'Nokia 1100', qty: 15, price: 17.99, description: 'The best phone', category_id: Category.last.id)