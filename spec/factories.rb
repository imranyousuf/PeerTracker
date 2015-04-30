FactoryGirl.define do
  factory :student, class: User do
    first_name "Lucas"
    last_name "Ness"
    email "lucas@brawl.com"
    password "nomorebrawl"
    encrypted_password "nomorebrawl"
    user_id 30000001
  end

  factory :student2, class: User do
    first_name "Link"
    last_name "Noname"
    email "link@brawl.com"
    password "yesmorebrawl"
    encrypted_password "yesmorebrawl"
    user_id 30000002
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
    password "nomore169"
    encrypted_password "nomore169"
    user_id 10000001
  end

  factory :course, class: Course do 
    course_name "CS 169"
    user_id 20000001
  end

  factory :team, class: Team do 
    name "dogs who code"
    course_id 1
  end

  factory :assignment, class: Assignment do
    assignment_name "project1-1"
  end

  factory :feedback1, class: Feedback do
    comments = "LOL you good" 
    rating = 25
    receiver_id = 30000001
    assignment_id = 1 
  end

  factory :feedback2, class: Feedback do
    comments = "LOL you suck" 
    rating = 10
    receiver_id = 30000001
    assignment_id = 1 
  end
end
