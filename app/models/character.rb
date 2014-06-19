class Character < ActiveRecord::Base
  belongs_to :television_show

  validates :name,
    presence: true, uniqueness:{scope: :television_show_id}
  validates :actor, presence: true

  validates :television_show_id, presence: true, numericality: {only_integer: true}
end
