FactoryBot.define do
  factory :post do
    user_id               {1}
    sequence(:title)      {|n|"post_title#{n}"}
    sequence(:location)   {|n|"location#{n}"}
    sequence(:body)       {|n|"post_body#{n}"}
    post_image            {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test.jpg'))}

  end
end