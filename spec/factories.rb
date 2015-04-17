FactoryGirl.define do
  factory :student, class: User do
    name "Lucas Ness"
    email "lucas@brawl.com"
    password "nomorebrawl"
    encrypted_password "nomorebrawl"
    user_id 30000001
  end

  factory :instructor, class: User do
    name "Kevin Casey"
    email "casey@berkeley.edu"
    password "nomore169"
    encrypted_password "nomore169"
    user_id 20000001
  end
end
