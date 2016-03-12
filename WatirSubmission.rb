# Implementation of Coding Challenge given by Synup
# Using Watir to Submit listings to various sites.

# Require the Waitr Web Driver
require 'watir-webdriver'

=begin
 Steps required to Submit a listing to YellowHoo Site. The File should do the same thing as human do
 	1. Login  --> Login Details. Since it allows only one free listing per login, I need a few. Say 10
 	              Let's create an Array of pairs. We will use each listing per login.
 	2. Design the navigation to the pages --> Login --> 
 	   a. To Add Lisitngs URL -> http://www.yellowhoo.com/members
       b. Add your business button click	
       c. Free one time button click
       d. Add your business
       e. Within that Add your business
    3. Complete the Navigation, Submit the listing and Verify it.
=end

# I had made it look like a Interfaces in JAVA a little.
# Javaish guy I'm. Will make it Rubyish soon
module WatirDetails
	# Lising details to be submitted in the site
	@site_details = {}
	@verified   = false
	@successful = false
	@submitted  = false
	@login_details = [] # 0 - Username/email 1 - Password
	@site_url  = nil;
	

	# Submit the given details to the corresponding site
	def submit!
	end

	# Login and check if you are in the right page after login.
	# Verification is done using the urls
	def login
	end
end
class YellowHooSubmitter
	#Include the module
	include WatirDetails	
	
	# Constructor -> Get the listing details to be submitted in the given site
	def initialize(listingDetails, site_url,login_details)
		@site_details  = listingDetails
		@login_details =login_details
		@site_url      = site_url
		@browser   = Watir::Browser.new :firefox
	end

	# We actually implement the Dummy method present in the WatirDetails Module
	def login
		# Set Home Page
		@browser.goto @site_url
		@browser.button(:data-target="#login").click
	end
end