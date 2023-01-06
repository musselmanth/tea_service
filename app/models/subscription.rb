class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  enum status: [:cancelled, :active]

  accepts_nested_attributes_for :subscription_teas

  validates_numericality_of :frequency, :price
  validates_presence_of :title, :frequency, :price

  def tea_summary
    subscription_teas.pluck(:tea_id, :quantity).map do |tea_id, quantity|
      {tea_id: tea_id.to_s, quantity: quantity}
    end
  end
end
