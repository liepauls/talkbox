class User < ActiveRecord::Base
	has_many :messages
	validates :username, presence: { message: "field can't be left empty" }, length: { minimum: 2, message: "must be at least 2 characters long"}
end
