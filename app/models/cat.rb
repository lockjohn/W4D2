# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  
  #age method
  
  COLORS = ['black', 'white', 'calico', 'brown' , 'grey', 'orange', 'striped']
  
  
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS}
  validates :sex, inclusion: { in: %w(M F)}
  
  def age
    Date.today.year - self.birth_date.year unless self.birth_date.nil?
  end
  
  has_many :cat_rental_requests,
  foreign_key: :cat_id,
  class_name: :CatRentalRequest,
  dependent: :destroy
  
end
