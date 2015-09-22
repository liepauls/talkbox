class Room < ActiveRecord::Base
  has_many :messages, dependent: :delete_all
  validates :name, presence: true, uniqueness: true
  belongs_to :user

  def update_with_password(attributes)
    if attributes[:name] == '' && attributes[:password] != ''
      update(password: attributes[:password])
    elsif attributes[:password] != ''
      update attributes
    else
      update(name: attributes[:name])
    end
  end
end
