require File.expand_path("../lib/hashifiable", File.dirname(__FILE__))
require 'spec_helper'

class TestUser < Struct.new(:id, :name, :credit_card, :secret_token)
  extend Hashifiable
  hashify :id, :name
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
end
