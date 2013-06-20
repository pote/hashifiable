require File.expand_path("../lib/hashifiable", File.dirname(__FILE__))
require 'spec_helper'

class TestUser < Struct.new(:id, :name, :credit_card, :secret_token)
  extend Hashifiable
  hashify :id, :name, :two_times_two => Proc.new { 2 * 2 }, :encrypted_token => Proc.new { secret_token + ' secret sauce' }
end

describe Hashifiable do
  before do
    @user = TestUser.new(1, 'pote', '1123123241241', 'i2j34i2j34302843')
  end

  it 'should have a to_hash method' do
    @user.respond_to?(:to_hash).should be_true
  end

  it 'should have a to_json method' do
    @user.respond_to?(:to_json).should be_true
  end

  it 'should have a hash representation of the desired attributes' do
    @user.to_hash.keys.include?(:id).should be_true
    @user.to_hash.keys.include?(:name).should be_true
  end

  it 'shouldnt have unspecified data' do
    @user.to_hash.keys.include?(:credit_card).should be_false
    @user.to_hash.keys.include?(:secret_token).should be_false
  end

  it 'should include procs in the hash representation' do
    @user.to_hash.keys.include?(:two_times_two).should be_true
  end

  it 'should return the output of the function and not a proc' do
    @user.to_hash[:two_times_two].should == 4
  end

  it 'should call the methods on the fly instead of just assignign whatever the result is at definition time' do
    @user.to_hash[:encrypted_token].should == @user.secret_token + ' secret sauce'

    @user.secret_token = 'NEW STUFF'

    @user.to_hash[:encrypted_token].should == @user.secret_token + ' secret sauce'
  end
end
