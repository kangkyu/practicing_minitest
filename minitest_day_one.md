#minitest practice 03-12-15

```r
rails new practicing_minitest
cd practicing_minitest
subl .
```

```rb
# test_helper.rb

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
```

```rb
# Gemfile

group :test do
  gem 'minitest-rails'
  gem 'minitest-reporters'
end
```

```r
bundle install
```

```rb
# test_helper.rb

require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]
```

```rb
# config/initializers/backtrace_silencers.rb

Rails.backtrace_cleaner.add_silencer { |line| line =~ /rbenv/ }
```

start testing...

```r
rails g integration_test posts_index
```

```rb
# test/integration/posts_index_test.rb

require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end
end
```

```r
rake test

=> db/schema.rb doesn't exist yet.

rails g migration create_posts title:string body:text
rake db:migrate
```

```rb
class PostsIndexTest < ActionDispatch::IntegrationTest
  
  test "list posts" do
    get "/"
    assert_response :success
    assert_template "index"
  end
end
```

```r
rake test

=> No route matches [GET] "/"
```

```c
# config/routes.rb

root "posts#index"
```

```r
rake test

=> uninitialized constant PostsController
```

```r
rails g minitest:controller posts
```

```rb
# test/controllers/posts_controller_test.rb

require "test_helper"

class PostsControllerTest < ActionController::TestCase
  def test_sanity
    flunk "Need real tests"
  end
end

```

```r
rake test:controllers

=> Need real tests
```

```rb
require "test_helper"

class PostsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end
end
```

```r
rake test:controllers

=> @controller is nil
```

```rb
# app/posts_controller.rb

class PostsController < ApplicationController
end
```

```r
rake test:controllers

=> The action 'index' could not be found for PostsController
```

```rb
# app/posts_controller.rb

class PostsController < ApplicationController
+  def index
+  end
end
```

```r
rake test:controllers

=> Missing template posts/index

mkdir app/views/posts 
touch app/views/posts/index.html.erb

rake test:controllers

=> pass!
```

```r
rake test

=> pass!
```

```rb
require "test_helper"

class PostsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
+    assert_not_nil assigns(:posts)
  end
end
```

```r
rake test

=> Expected nil to not be nil.
```

```rb
# app/posts_controller.rb

class PostsController < ApplicationController
  def index
+    @posts = Post.all
  end
end
```
```r
rake test

=> uninitialized constant PostsController::Post
```

```r
rails g minitest:model post
```

```rb
# test/models/post_test.rb

require "test_helper"

class PostTest < ActiveSupport::TestCase

  def post
    @post ||= Post.new
  end

  def test_valid
    assert post.valid?
  end

end
```
```rb
# Read about fixtures at
# http://api.rubyonrails.org/classes/ActiveRecord/Fixtures.html

# This model initially had no columns defined.  If you add columns to the
# model remove the '{}' from the fixture names and add the columns immediately
# below each fixture, per the syntax in the comments below
#
one: {}
# column: value
#
two: {}
#  column: value
```

```c
rake test:models

=> Error PostTest#test_valid:
```

```rb
# app/models/post.rb

class Post < ActiveRecord::Base
end
```

```r
rake test:models

=> pass!
```
```r
rake test

=> pass!
```

```
rails generate integration_test posts_show
```

```rb
# test/integration/posts_show_test.rb

require 'test_helper'

class PostsShowTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:one)
  end

  test "show detail of a post" do
    get post_path(@post)
    assert_response :success
    assert_template "show"
  end
end

```
```r
# test/fixtures/posts.yml
one:
  title: title one
  body: body one
two:
  title: title two
  body: body two

```
```
rake test
=> undefined method `post_path'
```
```rb
  resources :posts
```
```
rake test
=> The action 'show' could not be found for PostsController

rake test:controllers
```
```rb
  def setup
    @post = posts(:one)
  end

  test "should get show" do
    get :show, id: @post.id
    assert_response :success
  end
```
```
rake test:controllers
=> The action 'show' could not be found for PostsController
```

```rb
  def show
  end
```

```
rake test:controllers
=> Missing template posts/show

touch app/views/posts/show.html.erb

rake test:controllers
=> pass

rake test
=> pass
```