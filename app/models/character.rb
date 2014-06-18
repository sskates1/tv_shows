class Actor < ActiveRecord::Base
  belongs_to :television_show

  validates :name,
    presence: true
end
