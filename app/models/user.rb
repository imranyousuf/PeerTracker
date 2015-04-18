class User < ActiveRecord::Base
  has_and_belongs_to_many :courses 
  has_and_belongs_to_many :teams


  has_many :giver_feedbacks, :class_name => "Feedback", :foreign_key => 'giver_user_id'
  has_many :receiver_feedbacks, :class_name => "Feedback", :foreign_key => 'receiver_user_id'

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #`attr_accessor :teams
end
