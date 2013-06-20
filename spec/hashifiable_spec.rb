require 'spec_helper'

class TestUser < Struct.new(:id, :name, :credit_card, :secret_token)
  extend Hashifiable
  hashify :id, :name, :two_times_two => Proc.new { 2 * 2 }, :encrypted_token => Proc.new { secret_token + ' secret sauce' }, lambdas_at_work: ->() { 2 * 2 }
end

describe Hashifiable do
  let(:user) { TestUser.new(1, 'pote', '1123123241241', 'i2j34i2j34302843') }

  it 'should have a to_h method' do
    user.respond_to?(:to_h).should be_true
  end

  it 'support to_hash for old fashioned people' do
    user.respond_to?(:to_hash).should be_true
  end

  it 'should have a hash representation of the desired attributes' do
    user.to_h.keys.include?(:id).should be_true
    user.to_h.keys.include?(:name).should be_true
  end

  it 'shouldnt have unspecified data' do
    user.to_h.keys.include?(:credit_card).should be_false
    user.to_h.keys.include?(:secret_token).should be_false
  end

  it 'should change the hash representation when the attribute/method output changes' do
    user.to_h[:id].should == 1
    user.id = 2
    user.to_h[:id].should == 2
  end

  it 'should include procs in the hash representation' do
    user.to_h.keys.include?(:two_times_two).should be_true
  end

  it 'should return the output of the function and not a proc' do
    user.to_h[:two_times_two].should == 4
  end

  it 'should call the methods on the fly instead of just assignign whatever the result is at definition time' do
    user.to_h[:encrypted_token].should == user.secret_token + ' secret sauce'

    user.secret_token = 'NEW STUFF'

    user.to_h[:encrypted_token].should == user.secret_token + ' secret sauce'
  end

  it 'should also allow lambdas to be used instead of Procs' do
    user.to_h[:lambdas_at_work].should == 4
  end
end
