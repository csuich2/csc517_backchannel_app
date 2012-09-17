# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

# Create 50 users
for i in 1 .. 10
  User.create(
    {
        :username => "test#{i}",
        :password => 'testing',
        :password_confirmation => 'testing',
        :is_admin => (i <= 5 ? true : false),
    }
  )
end

# Create 10 categories
for i in 1 .. 10
  Category.create(
      {
          :name => "Category #{i}"
      }
  )
end

# Create some posts by an admin and some for a non-admin
for i in 1 .. 10
  Post.create(
      {
        :title => "Admin post #{i}",
        :text => 'asldkjfalsdkfjalknwelnrlqwerugoaernlw',
        :user_id => User.where("username = 'test1'").first.id,
        :category_id => Category.where("name = 'Category #{i}'").first.id,
      }
  )
end
for i in 1 .. 10
  Post.create(
      {
          :title => "Non-admin post #{i}",
          :text => 'qwnqhb qlwenljfdb aer taewlkfnqwe',
          :user_id => User.where("username = 'test5'").first.id,
          :category_id => Category.where("name = 'Category #{i}'").first.id,
      }
  )
end


# Create some comments on some of the posts
for i in 1 .. 10
  for j in 1 .. 2
    Comment.create(
        {
            :text => "Test comment #{i}-#{j}",
            :user_id => User.where("username = 'test#{i}'").first.id,
            :post_id => Post.where("title = 'Admin post #{j}'").first.id,
        }
    )
  end
  for j in 1 .. 2
    Comment.create(
        {
            :text => "Test comment #{i}-#{j}",
            :user_id => User.where("username = 'test#{i}'").first.id,
            :post_id => Post.where("title = 'Non-admin post #{j}'").first.id,
        }
    )
  end
end
