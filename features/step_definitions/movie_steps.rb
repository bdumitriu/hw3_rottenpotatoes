# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert_match(/.*#{Regexp.escape(e1)}.*#{Regexp.escape(e2)}.*/m, page.body)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(/\s*,\s*/)
  ratings.each do |rating|
    step "I #{uncheck}check \"ratings_#{rating}\""
  end
end

Then /I should see all of the movies/ do
  movies = Movie.all
  movies.each do |movie|
    step "I should see \"#{movie.title}\""
  end
end

Then /I should see no movie/ do
  movies = Movie.all
  movies.each do |movie|
    step "I should not see \"#{movie.title}\""
  end
end
