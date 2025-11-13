class Guest < ApplicationRecord
  belongs_to :table, optional: true

  validates :name, presence: true

  def tablemates
    return Guest.none unless table
    table.guests.where.not(id: id).order(:name)
  end
end
