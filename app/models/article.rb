class Article < ActiveRecord::Base
  belongs_to :article_type
  belongs_to :user
end
