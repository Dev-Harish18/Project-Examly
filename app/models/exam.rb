class Exam < ApplicationRecord
  before_save :create_exam_code
  
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy

  validates :subject, presence: true, uniqueness: { case_sensitive: false } 
  validates :pass_mark, presence: true
  validates :total_marks, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def create_exam_code
    loop do
      code = SecureRandom.hex(6)[0..5]
      self.exam_code = code
      break unless self.class.exists?(exam_code: code)
    end
  end
  
end
