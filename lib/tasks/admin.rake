# frozen_string_literal: true
#
require 'io/console'

def prompt(msg, noecho: false)
  $stdout.write "#{msg}: "
  response = ''
  while response.empty?
    response = noecho ? $stdin.noecho(&:gets) : $stdin.gets
    response.chomp!
  end

  response
end

namespace :admin do
  desc 'Create a user'
  task create_user: :environment do
    puts 'Creating a user...'

    email = prompt('Email')
    first_name = prompt('First Name')
    last_name = prompt('Last Name')
    password = prompt('Password (will be hidden)', noecho: true)

    user = User.create(
      email: email, 
      first_name: first_name,
      last_name: last_name,
      password: password, 
      password_confirmation: password
    )
    if user.persisted?
      puts 'Created successfully!'
    else
      puts 'Error creating user: ' + user.errors.full_messages.join("\n")
    end
  end
end
