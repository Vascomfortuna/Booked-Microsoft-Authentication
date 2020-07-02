# Booked-Microsoft-Authentication

## INSTALLING

 1a)There's a pre-installed booked folder on this project where you can just move it to your server
 
 1b)Take the "booked-microsoft-login" folder and add it to your current Booked app. 
	Substitute any files when asked.
	
## CONFIG

  1) After installing, you need to config the file "microsoftConfig.php", located on
		"booked\WebServices\MicrosoftLogin".
		
  2) You will need to define ROOT to your root URL, and define CLIENT_ID and CLIENT_SECRET
		with the credentials from your "portal.azure.com" app (Check below how to get one).
		
		2.1) Your app must have the redirect url to your file "microsoftProfile.php".
			Ex:"http://localhost/booked/WebServices/MicrosoftLogin/microsoftProfile.php".
			
  3) To the microsoft login button's href, located in "tpl/login.tpl", you need to put your CLIENT_ID 
		and redirect_uri to your "microsoftProfile.php", from 2.1).
		
  4) After you do this, you are all set and your booked app should have microsoft authentication.

## GETTING A PORTAL.AZURE APP RUNNING

  1) Go to "portal.azure.com" and login with a account. 
		
  2) Search for "Register application" on the top bar and select it.
  
  3) Select "Create a new application".
  
  4) Choose your name and select the option to allow personal accounts.
  
  5) On the Redirect URL field, select Web and add the URL to your "microsoftProfile.php" file.
		Ex:"http://localhost/booked/WebServices/MicrosoftLogin/microsoftProfile.php".

  6) After creating your app, you should see the app client's ID 
		that you need to define on "microsoftConfig.php".
  
  7) On the left bar you should see a secrets tab. This tab allows to create your secret 
		that you need also define on "microsoftConfig.php".
		
  8) After this you should be all set.
		
### Warning
  Make sure your Redirect URI is set on "Authentication" tab. 
  If it isnt, you can add it by selecting "Add new platform" and adding the "microsoftProfile.php" URL path.
  
  When you create your app it should come with "user.read" permissions, that the app needs for the user login to work.
  You can check this on "API Permissions" tab, where you can add "user.read" from "micrsoft.graph".
  