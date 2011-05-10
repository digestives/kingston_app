require 'spec_helper'

describe PagesController do
	render_views # render the views for this kind of test

  describe "GET 'index'" do

    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
    	get 'index'
    	response.should have_selector("title", :content => "Kingston Leisure | Index")
    end
  end

  describe "GET 'about'" do

    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
    	get 'about'
    	response.should have_selector("title", :content => "Kingston Leisure | About")
    end
  end

  describe "GET 'contact'" do

    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
    	get 'contact'
    	response.should have_selector("title", :content => "Kingston Leisure | Contact")
    end
  end

  describe "GET 'terms'" do

    it "should be successful" do
      get 'terms'
      response.should be_success
    end

    it "should have the right title" do
    	get 'terms'
    	response.should have_selector("title", :content => "Kingston Leisure | Terms")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
    	get 'help'
    	response.should have_selector("title", :content => "Kingston Leisure | Help")
    end
  end

end

