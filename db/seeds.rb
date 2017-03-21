admin = User.new(email: 'admin@gmail.com', password: '123456')
admin.add_role :admin
admin.save
