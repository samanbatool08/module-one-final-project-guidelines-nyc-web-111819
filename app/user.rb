class User < ActiveRecord::Base
    has_many :reviews
    has_many :restaurants, through: :reviews

    # def reviews
    #     Review.all.select do |review|
    #         review.user_id == self.id
    #     end
    # end
end
