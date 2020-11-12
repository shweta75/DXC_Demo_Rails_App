class Person < ApplicationRecord
     # encrypted_id key: 'shd6asdkasdhjhd78' 
     validates :first_name, :last_name, :email, :age, :gender, presence: true
     validates :email, uniqueness: true
     validates :first_name, :last_name, length: {minimum: 4}
 
 
end
