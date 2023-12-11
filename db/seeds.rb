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
User.create!(username: 'dolo', email: 'doloponda@gmail.com', password: 'password')

# Links
Link.create!(user_id: 1, name: 'Sample Link 1', url: 'https://example.com', link_type: 'Regular')
Link.create!(user_id: 1, name: 'Sample Link 2', url: 'https://example.com', link_type: 'Temporary', expires_at: Time.now + 1.week)
Link.create!(user_id: 2, name: 'Sample Link 3', url: 'https://example.com', link_type: 'Private', password: 'secret_password')
Link.create!(user_id: 2, name: 'Sample Link 4', url: 'https://example.com', link_type: 'Ephemeral')
