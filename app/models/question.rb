class Question < ApplicationRecord
  belongs_to :exam
  has_many :answers, dependent: :destroy

  validates :question, uniqueness: { case_sensitive: false } 
end