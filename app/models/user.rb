class User < ActiveRecord::Base
  require 'csv'
  has_and_belongs_to_many :courses 
  has_and_belongs_to_many :teams

  def self.import(file)
     CSV.foreach(file.path, headers: true) do |row|
         User.create! row.to_hash
     end
  end
  
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #`attr_accessor :teams
end
