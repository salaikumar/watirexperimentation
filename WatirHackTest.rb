load 'WatirSubmission.rb'

location_params = {
        "name"=>"Four Points by Sheraton Nashville Airport",
        "biz_url"=>"http://www.fourpointsnashvilleairport.com",
        "street"=>"800 Royal Pkwy", "city"=>"Wales",
        "postal_code"=>"37214",
        "phone"=>"615-884-9777",
        "owner_first_name"=>"Sample",
        "owner_last_name"=>"SampleSubmitter",
        "state_iso"=>"2",
        "country_iso"=>"US",
        "category"=>"Arts Entertainment",
        "sub_category_name"=>"Night Clubs",
        "description"=>"sample text desc",
        "additional_info"=>"",
        "keywords" => 'sample,sample',
        "email" => 'sample@samplemail.com'
      }
      
SampleSubmitter = YellowHooSubmitter.new(location_params,"http://www.yellowhoo.com/",
										   ['saravanan1115@gmail.com','@Spire90039']	)
SampleSubmitter.submit!