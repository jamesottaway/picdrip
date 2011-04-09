require 'spec_helper'
require 'cancan/matchers'

describe Ability do  
  let(:user) { User.make }
  let(:album_for_user) { Album.new :user_id => user.id }
  let(:album_not_for_user) { Album.new }
  let(:photo_for_user) { Photo.new :album => album_for_user }
  let(:photo_not_for_user) { Photo.new :album => album_not_for_user }
  
  subject { Ability.new(user) }
  
  it { should be_able_to :manage, album_for_user }
  it { should_not be_able_to :manage, album_not_for_user }
  it { should be_able_to :manage, photo_for_user }
  it { should_not be_able_to :manage, photo_not_for_user }
end
