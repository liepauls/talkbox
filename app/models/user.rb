require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_many :messages
  has_many :rooms

  validates :username, uniqueness: true,
                       presence: { message: 'field can not be left empty' },
                       length:   { minimum: 3,
                                   message: 'must be at least 3 characters long' }

  validates :password, presence: { message: 'Field can not be left empty' },
                       length:   { minimum: 3,
                                   message: 'must be at least 3 characters long' }
end
