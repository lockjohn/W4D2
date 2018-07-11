# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  belongs_to :cat,
  foreign_key: :cat_id,
  class_name: :Cat
  
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w( PENDING DENIED APPROVED )}
  
  def overlapping_requests
    current_start = self.start_date
    current_end = self.end_date
    CatRentalRequest.select(cat_rental_requests.*).where('start_date = ?', current_start).where('start_date = ?', current_end)
    .where({start_date: current_start..current_end})
  end
end 
