class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  enum status: [:cancelled, :active]

  accepts_nested_attributes_for :subscription_teas

  validates_numericality_of :frequency, :price
  validates_presence_of :title, :frequency, :price
end
