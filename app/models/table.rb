class Table < ApplicationRecord
  has_many :guests, dependent: :nullify

  def used_seats = guests.count
  def free_seats = [capacity - used_seats, 0].max
  def display_name = number.to_s
end
