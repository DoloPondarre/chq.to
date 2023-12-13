# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Users
User.create!(username: 'user1', email: 'user1@example.com', password: 'password')
User.create!(username: 'user2', email: 'user2@example.com', password: 'password')

# Links
regular = Link.create!(user_id: 1, name: 'TFI Regular', url: 'https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf', link_type: 'Regular')
temporal = Link.create!(user_id: 1, name: 'TFI Temporary', url: 'https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf', link_type: 'Temporary', expires_at: Time.now + 1.week)
privado = Link.create!(user_id: 1, name: 'TFI Private', url: 'https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf', link_type: 'Private', password: 'password')
efimero = Link.create!(user_id: 1, name: 'TFI Ephemeral', url: 'https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf', link_type: 'Ephemeral')

link1 = Link.create!(user_id: 2, name: 'TFI Temporary', url: 'https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf', link_type: 'Temporary', expires_at: Time.now - 1.day)
link2 = Link.create!(user_id: 2, name: 'TFI Ephemeral', url: 'https://catedras.linti.unlp.edu.ar/pluginfile.php/133107/mod_resource/content/1/tfi.pdf', link_type: 'Ephemeral')

# Accesses
regular.accesses.create!(ip_address: '127.0.0.1', created_at: '2023-12-10 19:11:39 -0300')
regular.accesses.create!(ip_address: '128.0.0.1', created_at: '2023-12-10 20:10:00 -0300')
regular.accesses.create!(ip_address: '127.0.0.1', created_at: '2023-12-11 19:11:39 -0300')

temporal.accesses.create!(ip_address: '127.0.0.1', created_at: '2023-12-10 19:11:39 -0300')
temporal.accesses.create!(ip_address: '128.0.0.1', created_at: '2023-12-11 19:11:39 -0300')

privado.accesses.create!(ip_address: '127.0.0.1', created_at: '2023-12-10 19:11:39 -0300')
privado.accesses.create!(ip_address: '128.0.0.1', created_at: '2023-12-10 20:10:00 -0300')

link1.accesses.create!(ip_address: '127.0.0.1', created_at: '2023-12-10 19:11:39 -0300')
link1.accesses.create!(ip_address: '128.0.0.1', created_at: '2023-12-11 19:11:39 -0300')

link2.accesses.create!(ip_address: '127.0.0.1', created_at: '2023-12-10 19:11:39 -0300')