class AddBookingToCity < ActiveRecord::Migration
  def change
    add_reference :cities, :booking, index: true, foreign_key: true
  end
end
