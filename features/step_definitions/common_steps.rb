
Given /^I want to shorten "([^"]*)"$/ do |url|
  @url = url
end


Then /^I should see its shortened version$/ do
  url = ShortenedUrl.first(:conditions => { :url => @url })
  Then "I should see \"#{url.shortened}\""
end

Given /^the following urls exist:$/ do |urls_table|
  urls_table.hashes.each do |attributes_hash|
    ShortenedUrl.create!(attributes_hash)
  end
end

Then /^I should be redirected to "([^"]*)"$/ do |page|
  puts response.should redirect_to(page)
end