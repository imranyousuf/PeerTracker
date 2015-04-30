class User < ActiveRecord::Base
  require 'csv'
  has_and_belongs_to_many :courses 
  has_and_belongs_to_many :teams
  attr_accessor :role


  has_many :giver_feedbacks, :class_name => "Feedback", :foreign_key => 'giver_user_id'
  has_many :receiver_feedbacks, :class_name => "Feedback", :foreign_key => 'receiver_user_id'

  def self.import(file)
     CSV.foreach(file.path, headers: true) do |row|
         User.create! row.to_hash
     end
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # Get the Average Rating of the user for that assignment
  def average_rating(assignment)
    # team = self.teams.find(team_id)
    # feedback = team.feedbacks.all.where(:receiver_id => self.user_id)
    feedback = assignment.feedbacks.where(:receiver_id => self.user_id)
    average = 0
    for f in feedback
      average += f.rating
    end
    if feedback.length != 0
      average = average/feedback.length
      average.to_s
    else
      'No feedback received'
    end
  end

  # Get the feedbacks received by this user for a particular assignment
  def feedback_received(assignment)
    feedback = assignment.feedbacks.where(:receiver_id => self.user_id)
  end

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #`attr_accessor :teams
end
