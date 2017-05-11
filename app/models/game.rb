class Game < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :notes, presence: true

end
