FactoryBot.define do
  factory :post do
    user_id               {1}
    title                 {"title of post"}
    location              {"location of post"}
    body                  {"body of post"}
    post_image            {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test.jpg'))}

  end
end