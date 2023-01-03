require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    describe 'the product should be valid' do
      it "should not error" do
        example1_cata = Category.create(name: 'example')
        example1_proda = Product.create({name: 'example1', price: 599, quantity: 5, category: example1_cata})
        expect(example1_proda).to be_valid()
      end
    end
    describe 'the product should be invalid without a name' do
      it 'should fail the test ifi initialized without a name' do
        example1_cata = Category.create(name: 'example')
        example1_proda = Product.create({price: 599, quantity: 5, category: example1_cata})
        expect(example1_proda).to_not be_valid()
      end  
    end  
  end
end
