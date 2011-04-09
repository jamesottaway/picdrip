require 'spec_helper'
include ActiveModel::Validations

describe Album do
  FLICKR_ID = '123'
  
  subject { Album.make }
  
  it 'should have many photos' do
    association = Album.reflections[:photos]
    association.macro.should == :has_many
  end
  
  it 'should belong to a user' do
    association = Album.reflections[:user]
    association.macro.should == :belongs_to
  end
  
  it { should accept_nested_attributes_for :photos }
  it { Album.should have_validator PresenceValidator, :on => :title }
  it { Album.should have_validator PresenceValidator, :on => :description }
  it { Album.should have_validator PresenceValidator, :on => :user_id }
  
  it 'should persist the flickr photoset id' do
    subject.should_receive(:flickr_id=).with FLICKR_ID
    subject.should_receive(:save)
    
    subject.persist_flickr_id FLICKR_ID
  end
  
  it 'should know whether it is on flickr' do
    subject.should_not be_on_flickr
    subject.persist_flickr_id FLICKR_ID
    subject.should be_on_flickr
  end
end