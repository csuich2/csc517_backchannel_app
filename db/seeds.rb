# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

require 'digest/sha1'

users = User.create([ { :username => 'test',
                          :password => 'testing',
                          :password_confirmation => 'testing',
                          :is_admin => true },
                      { :username => 'test2',
                          :password => 'testing',
                          :password_confirmation => 'testing',
                          :is_admin => false },
                      { :username => 'test3',
                          :password => 'testing',
                          :password_confirmation => 'testing',
                          :is_admin => false }
                    ])

categories = Category.create([ { :name => 'Category 1' },
                               { :name => 'Category 2' },
                               { :name => 'Category 3' }
                             ])

posts = Post.create({ :title => 'Test post 1',
                          :text => 'lakjsdlfajdslfajsdlfjasdlfkjalsdfk',
                          :owner_id => User.where("username = 'test2'").first.id,
                          :category_id => Category.where("name = 'Category 1'").first.id }
                    )


comments = Comment.create([ { :text => 'Test comment from owner',
                                :owner_id => User.where("username = 'test2'").first.id,
                                :post_id => Post.where("title = 'Test post 1'").first.id },
                            { :text => 'Test comment from non-owner',
                                :owner_id => User.where("username = 'test3'").first.id,
                                :post_id => Post.where("title = 'Test post 1'").first.id }
                          ])
