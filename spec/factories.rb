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
  end

  factory :course, class: Course do 
    course_name "CS 169"
  end

  factory :team, class: Team do 
    name "dogs who code"
  end

  factory :assignment, class: Assignment do
    assignment_name "project1-1"
    deadline DateTime.new(2015, 5, 29)

  end

  factory :assignment2, class: Assignment do
    assignment_name "project1-2"
    deadline DateTime.new(2000, 5, 29)

  end
end
