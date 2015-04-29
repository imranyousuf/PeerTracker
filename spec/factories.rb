FactoryGirl.define do
  factory :student, class: User do
    first_name "Lucas"
    last_name "Ness"
    email "lucas@brawl.com"
    password "nomorebrawl"
    encrypted_password "nomorebrawl"
    user_id 30000001
  end

  factory :professor, class: User do
    first_name "Kevin"
    last_name "Casey"
    email "casey@berkeley.edu"
    password "nomore169"
    encrypted_password "nomore169"
    user_id 20000001
  end
  
  factory :instructor, class: User do
    first_name "Bryan"
    last_name "Munar"
    email "bkmunar@berkeley.edu"
  end

  factory :course, class: Course do 
    course_name "CS 169"
  end
end
