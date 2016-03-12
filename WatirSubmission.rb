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
class YellowHooSubmitter
	# Lising details to be submitted in the site
	@yellowHooListing = {}
	@verified   = false
	@successful = false
	@submitted  = false
	@logindetails = [] # 0 - Username/email 1 - Password

	# Constructor -> Get the listing details to be submitted in the given site
	def initialize(listingDetails={})
		@yellowHooListing = listingDetails
	end

	# Submit the given details to the corresponding site
	def submit!

	end

	# Provide the login credentials to be used
	def setLogin
	end

end