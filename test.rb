require './app'
require 'test/unit'
require 'rack/test'

set :environment, :test

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  
  def test_macaulay_culkin_returns_proper_movies
    get '/?actor=macaulay_culkin'
    assert last_response.ok?
    assert_equal '{"films":["Richie Rich","Saved!","Party Monster","Sex and Breakfast","My Girl","Changeland","The Pagemaster","Home Alone 2: Lost in New York","Adam Green\'s Aladdin","Home Alone","The Nutcracker","The Good Son","Getting Even with Dad","The Wrong Ferarri"]}', last_response.body
  end

  def test_home_alone_returns_proper_actors
    get '/?film=home_alone'
    assert last_response.ok?
    assert_equal '{"actors":["John Heard (actor)","Joe Pesci","Daniel Stern (actor)","Macaulay Culkin","Catherine O\'Hara"]}', last_response.body
  end
end