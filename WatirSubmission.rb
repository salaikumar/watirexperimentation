# Implementation of Coding Challenge given by Synup
# Using Watir to Submit listings to various sites.

# Require the Waitr Web Driver
require 'watir-webdriver'
require 'watir-scroll'
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

module WatirDetails
	# Lising details to be submitted in the site
	@site_details = {}
	@successful = false
	@login_details = []
	@site_url  = nil;
	
	# Submit the given details to the corresponding site
	def submit!
	end

	# Login and check if you are in the right page after login.
	def login
	end
end

class YellowHooSubmitter
	#Include the module
	include WatirDetails	
	
	# Constructor -> Get the listing details to be submitted in the given site
	def initialize(listingDetails, site_url,login_details)
		@site_details  = listingDetails
		@login_details = login_details
		@site_url      = site_url
		@browser       = Watir::Browser.new :chrome
	end

	def login
		@browser.goto @site_url
		@browser.window.maximize
		@browser.link(:id =>'modal-launcher').click
		Watir::Wait.until(){
			@browser.text_field(:id => 'username').visible?
		}

		@browser.text_field(:id => 'username').set @login_details[0]
		@browser.text_field(:id => 'password').set @login_details[1]
		@browser.button(:value => 'Login').click
	end

	def navigate
		# Wait till home page loads
		Watir::Wait.until(){
			@browser.url == "http://www.yellowhoo.com/members"
		}

		# Click on Add Your Business link
		@browser.div(:class=>"profile-usermenu").links.each do | link | 
			if link.text == 'ADD YOUR BUSINESS'
				link.click 
				break
			end
		end

		# Wait untill either buy package /add your business page loads
		Watir::Wait.until(){
			@browser.url == "http://www.yellowhoo.com/members/membership" ||
			@browser.div(:class => 'panel price panel-grey').exists?  # Add your business, select package panel exists
		}

		if @browser.url == 'http://www.yellowhoo.com/members/membership'
			@browser.element(:xpath => '//*[@id="plans"]/li[1]/ul/li[4]/a').click
			Watir::Wait.until(){
				@browser.url == "http://www.yellowhoo.com/members"
			}
			@browser.div(:class=>"profile-usermenu").links.each do | link | 
				if link.text == 'ADD YOUR BUSINESS'
					link.click 
					break
				end
			end
		end
		# Wait untill the menu loads
		Watir::Wait.until(){
			@browser.div(:class => 'panel price panel-grey').exists?			
		}	
		@browser.element(:xpath => '/html/body/div[2]/div/div/div[2]/div/div/div/div/div[3]/a[1]').click
	end

	def fillpageone
		Watir::Wait.until(){
			@browser.text_field(:id => 'listing_title').exists?			
		}
		@browser.text_field(:id => 'listing_title').set @site_details["name"]
		categories = @browser.ul(:class => 'dynatree-container').lis
		categories.each do |category|
			if category.text == @site_details[	"category"]
				category.a.click
				category.link(:text => @site_details["sub_category_name"]).click
			end
		end
		@browser.iframe(:id => "listing_description_ifr").send_keys @site_details['description']
		@browser.textarea(:id => 'listing_keywords').set @site_details['keywords']

	end
	def fillpagetwo
		# Page 2 Filling - Navigate to Address
		@browser.scroll.to :top
		@browser.div(:class => 'tabbable-panel').div(:class => 'tabbable-line').link(:text => 'Address').click		
	    #Country
	    @browser.div(:class => 'selectize-control col-sm-9 single',:index => 0).click
	    @browser.div(:class => 'selectize-dropdown single col-sm-9',:index => 0).div(:class => 'selectize-dropdown-content',:index => 0).div(:data_value => @site_details['country_iso']).click
		
		#State
		Watir::Wait.until(){
			@browser.element(:xpath => '//*[@id="address"]/div/div/div[2]/div/div[1]').exists? 
		}
		
		#Use Execute Script to make selectizable listen to user actions
		@browser.execute_script("
                                 var selectizeControl = document.getElementById('listing_state_id').selectize
                                 selectizeControl.enable()"
                                 )
		@browser.element(:xpath => '//*[@id="address"]/div/div/div[2]/div/div[1]').click
		Watir::Wait.until(){
			@browser.element(:xpath => '//*[@id="address"]/div/div/div[2]/div/div[2]').visible?
		}
		@browser.element(:xpath => '//*[@id="address"]/div/div/div[2]/div/div[2]').div(:data_value => @site_details['state_iso']).click

		#City
		Watir::Wait.until(){
			@browser.element(:xpath => '//*[@id="address"]/div/div/div[3]/div/div[1]/input').exists? 
		} 	
		#Use Execute Script to make selectizable listen to user actions
		@browser.execute_script("
                                 var selectizeControl = document.getElementById('listing_city_id').selectize
                                 selectizeControl.enable()"
                                 )
		#The input type text within the city select
		@browser.element(:xpath => '//*[@id="address"]/div/div/div[3]/div/div[1]/input').click

		# The Small box with options to select
		Watir::Wait.until(){
			@browser.element(:xpath => '//*[@id="address"]/div/div/div[3]/div/div[2]/div').visible?
		}
		@browser.element(:xpath => '//*[@id="address"]/div/div/div[3]/div/div[2]/div').div(:text => @site_details['city']).click

		# Postal Code
		@browser.text_field(:id => 'listing_postcode').set	@site_details['postal_code']
			
		#Address
		@browser.textarea(:id => 'listing_address').set @site_details['street']

	end
	def fillpagethree
		#Page 3 -- contact_info
		@browser.scroll.to :top
		@browser.div(:class => 'tabbable-panel').div(:class => 'tabbable-line').link(:text => 'Contact Info').click

		# Wait till the page loads
		#Contact Person

		Watir::Wait.until(){
			@browser.text_field(:id => 'listing_contact_person').visible?
		}
		contact_person = "#{@site_details['owner_first_name']}  #{@site_details['owner_last_name']}"
		@browser.text_field(:id => 'listing_contact_person').set contact_person		
		@browser.text_field(:id => 'listing_phone_number').set @site_details['phone']	
		@browser.text_field(:id => 'listing_website').set @site_details['biz_url']	
		@browser.text_field(:id => 'listing_email').set @site_details['email']	
	end
	def submit!
		login
		navigate
		fillpageone
		fillpagetwo	
		fillpagethree

		#save
		# @browser.button(:name => 'save').click
	end
end

	