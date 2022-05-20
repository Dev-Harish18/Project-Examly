class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  enum status: [:pass,:fail]
end