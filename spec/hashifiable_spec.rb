require 'spec_helper'

class TestUser < Struct.new(:id, :name, :credit_card, :secret_token)
  extend Hashifiable
  hashify :id,
          :name,
          :two_times_two => Proc.new { 2 * 2 },
          :encrypted_token => Proc.new { secret_token + ' secret sauce' },
          :lambdas_at_work => ->() { 2 * 2 }
end

describe Hashifiable do
  let(:user) { TestUser.new(1, 'pote', '1123123241241', 'i2j34i2j34302843') }

  it 'should have a to_h method' do
    user.should respond_to(:to_h)
  end

  it 'should have a to_stringy_h method' do
    user.should respond_to(:to_stringy_h)
  end

  it 'support to_hash for old fashioned people' do
    user.should respond_to(:to_hash)
  end

  it 'should have a hash representation of the desired attributes' do
    user.to_h.keys.should include(:id)
    user.to_h.keys.should include(:name)
    user.to_stringy_h.keys.should include('id')
    user.to_stringy_h.keys.should include('name')
  end

  it 'shouldnt have unspecified data' do
    user.to_h.keys.should_not include(:credit_card)
    user.to_h.keys.should_not include(:secret_token)
    user.to_stringy_h.keys.should_not include('credit_card')
    user.to_stringy_h.keys.should_not include('secret_token')
  end

  it 'should change the hash representation when the method output changes' do
    user.to_h[:id].should == 1
    user.to_stringy_h['id'].should == 1
    user.id = 2
    user.to_h[:id].should == 2
    user.to_stringy_h['id'].should == 2
  end

  it 'should include procs in the hash representation' do
    user.to_h.keys.should include(:two_times_two)
    user.to_stringy_h.keys.should include('two_times_two')
  end

  it 'should return the output of the function and not a proc' do
    user.to_h[:two_times_two].should == 4
    user.to_stringy_h['two_times_two'].should == 4
  end

  it 'should call the methods on the fly' do
    user.to_h[:encrypted_token].should == user.secret_token + ' secret sauce'
    user.to_stringy_h['encrypted_token'].should == user.secret_token + ' secret sauce'

    user.secret_token = 'NEW STUFF'

    user.to_h[:encrypted_token].should == user.secret_token + ' secret sauce'
    user.to_stringy_h['encrypted_token'].should == user.secret_token + ' secret sauce'
  end

  it 'should also allow lambdas to be used instead of Procs' do
    user.to_h[:lambdas_at_work].should == 4
    user.to_stringy_h['lambdas_at_work'].should == 4
  end
end
