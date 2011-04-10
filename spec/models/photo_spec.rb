require 'spec_helper'
include ActiveModel::Validations

describe Photo do
  FLICKR_ID = '123'
  
  let(:s3) { stub 'dragonfly accessor' }
  let(:thumb) { stub 'dragonfly thumbnail' }
  
  subject { Photo.make }
  
  it 'should belong to an album' do
    association = Photo.reflections[:album]
    association.macro.should == :belongs_to
  end
  
  it { should have_validator PresenceValidator, :on => :title }
  it { should have_validator LengthValidator, :on => :title, :options => { :maximum => 255 } }
  it { should have_validator PresenceValidator, :on => :description }
  it { should have_validator PresenceValidator, :on => :album_id }
  
  it 'should mark a photo as sent' do
    subject.should_receive(:uploaded=).with true
    subject.should_receive(:flickr_id=).with FLICKR_ID
    subject.should_receive :save
    
    subject.mark_as_sent FLICKR_ID
  end
  
  it 'should have a URL for the photo on S3' do
    subject.should_receive(:s3).and_return s3
    s3.should_receive :url
    
    subject.url
  end

  it 'should have a small square URL for the photo on S3' do
    subject.should_receive(:s3).and_return s3
    s3.should_receive(:thumb).with('100x100#').and_return thumb
    thumb.should_receive :url

    subject.small_square
  end

  it 'should have a medium URL for the photo on S3' do
    subject.should_receive(:s3).and_return s3
    s3.should_receive(:thumb).with('500x500').and_return thumb
    thumb.should_receive :url

    subject.medium
  end
end