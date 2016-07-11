Given /I have added "(.*)" with rating "(.*)"/ do |title, rating|
  steps %Q{
    Given I am on the Create New Movie page
    When  I fill in "Title" with "#{title}"
    And   I select "#{rating}" from "Rating"
    And   I press "Save Changes"
  }
end

Then /I should see "(.*)" before "(.*)" on (.*)/ do |string1, string2, path|
  step "I am on #{path}"
  regexp = /#{string1}.*#{string2}/m #  /m means match across newlines
  page.body.should =~ regexp
end



Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body =~ /#{e1}.*#{e2}/m, "#{e1} was not before #{e2}"
end


Then /^the director of "(.*?)" should be "(.*?)"$/ do |movie_title, new_director|
  movie = Movie.find_by_title movie_title
  movie.director.should == new_director
end

