require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user validatiuons" do
    describe "should fail if password and password_confirmation fields are different" do
      it "should pass when 'examplepass' and 'examplepass' is given for password and password_confirmation fields respectively" do
        new_user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        expect(new_user1).to be_valid()
      end
      it "should fail when 'examplepass' and 'examplepasta' is given for password and password_confirmation fields respectively" do
        new_user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepasta'})
        expect(new_user1).to_not be_valid()
      end   
    end
    describe "password must be 8 chars in length to be accepted" do
      it "Should fail if password is less than 8 chars" do
        new_user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'example', password_confirmation: 'example'})
        expect(new_user1).to_not be_valid()
      end
      it "Should pass if password is 8 or more chars" do
        new_user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplep', password_confirmation: 'examplep'})
        expect(new_user1).to be_valid()
      end  
    end
    describe "should require a unique email, no duplicates within the system, case insensitive" do
      it "should fail if a user account creation is attempted with an email already in the system" do
        user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        user2 = User.create({first_name: 'firstName', last_name: 'lastName', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        expect(user2).to_not be_valid()
      end
      it "should fail if a user account creation is attempted with an email already in the system though some of the letters are capitalized in email" do
        user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        user2 = User.create({first_name: 'firstName', last_name: 'lastName', email: 'eXAMple@emAIl.cOm', password: 'examplepass', password_confirmation: 'examplepass'})
        expect(user2).to_not be_valid()
      end    
    end
    describe "should require a first and last name and an email to be valid" do
      it "should fail if first name is ommited on user creation" do
        user1 = User.create({last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        expect(user1).to_not be_valid()
      end
      it "should fail if last name is ommited on user creation" do
        user1 = User.create({first_name: 'first', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        expect(user1).to_not be_valid()
      end
      it "should fail if email is ommited on user creation" do
        user1 = User.create({first_name: 'first', last_name: 'last', password: 'examplepass', password_confirmation: 'examplepass'})
        expect(user1).to_not be_valid()
      end
    end    
  end
  describe '.authenticate_with_credentials' do
    describe "should only pass if email and password match the user" do
      it "should pass given the above are both correct" do
        user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        user = User.authenticate_with_credentials('example@email.com', 'examplepass')
        expect(user).to_not be_nil()
      end
      it "should return nil if the password is incorrect" do
        user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        user = User.authenticate_with_credentials('example@email.com', 'wrongpass')
        expect(user).to be_nil()
      end
      it "should return nil if the email is incorrect" do
        user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        user = User.authenticate_with_credentials('wrong@email.com', 'examplepass')
        expect(user).to be_nil()
      end
      it "should pass given the above are both correct and there is email white space and capitalization" do
        user1 = User.create({first_name: 'first', last_name: 'last', email: 'example@email.com', password: 'examplepass', password_confirmation: 'examplepass'})
        user = User.authenticate_with_credentials(' eXAmple@emAIl.com  ', 'examplepass')
        expect(user).to_not be_nil()
      end
    end
  end
end
