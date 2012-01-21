# encoding: utf-8
class Product < ActiveRecord::Base
  validates :title, uniqueness: true
  validates :title, :description, :image_url, presence: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)}i,
    message: 'はGIF、JPG、PNG画像のURLでなければなりません'
  }
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
end
