<?php
require_once("microsoftConfig.php");

$code = filter_input(INPUT_GET,'code'); 
$error = filter_input(INPUT_GET,'error');
$error_desc = 'Error: '.$error .'<br/>Description: '. filter_input(INPUT_GET,'error_description');

verifyError($code,$error,$error_desc);

$url="https://login.microsoftonline.com/consumers/oauth2/v2.0/token";
$postFields = "client_id=".CLIENT_ID. 
                "&scope=user.read". //Permissions we need from user
                "&redirect_uri=".ROOT."WebServices/MicrosoftLogin/microsoftProfile.php". 
                "&grant_type=authorization_code". 
                "&client_secret=".CLIENT_SECRET. 
                "&code=".$code;

$response = requestPost($url,$postFields);

$access_token = $response['access_token'];
$token_error = $response['error'];
$token_error_desc ='Token Error: '.$token_error. '<br/>Description: '. $response['error_description'];

verifyError($access_token,$token_error,$token_error_desc);

// Other parameters that come with access_token
//$token_type = $response['token_type']; 
//$scope = $response['scope']; 
//$id_token = $response['id_token']; 


$url="https://graph.microsoft.com/v1.0/me/";
$auth = "Authorization: Bearer ".$access_token;
$headers = array(
                'Content-Type: application/json',
                'Connection: Keep-Alive',
                'Accept: */*',
                $auth
                );

$response = requestGet($url, $headers);

echo $response;
/* Validated response example
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
    "displayName": "Username",
    "surname": "Smith",
    "givenName": "John",
    "id": "453765435325", 
    "userPrincipalName": "johnsmith@hotmail.com",
    "businessPhones": [],
    "jobTitle": null,
    "mail": null,
    "mobilePhone": null,
    "officeLocation": null,
    "preferredLanguage": null
}*/



//----------------FUNCTIONS---------------------//

/*
    Parameters: url(String), postFields(String in url format)
    Returns: response (Array)
*/
function requestPost($url,$postFields,$headers = array(
                'Content-Type: application/x-www-form-urlencoded',
                'Connection: Keep-Alive',
                'Accept: */*')){

    $ch = curl_init(); 

    curl_setopt($ch, CURLOPT_URL,$url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($ch, CURLOPT_POSTFIELDS,$postFields); 
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_USERAGENT, 'BookedAPI-PHP/v0.1.1');

    $response = json_decode(curl_exec($ch),true);

    curl_close ($ch);

    return $response;
}

/*
    Parameters: $url(String), $headers (array)
	Returns: response (JSON)
*/

function requestGet($url,$headers){
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL,$url);
    curl_setopt($ch, CURLOPT_POST, 0);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    
    $response = curl_exec($ch); 

    curl_close ($ch);

    return $response;
 }

/*
    Parameters : $toCheck(mixed), 
                 $microsoftError (mixed, default:null)
                 $description (string, default: DEFAULT_ERROR_MESSAGE)
    Returns: void
*/
function verifyError($toCheck,$error = null,$description = DEFAULT_ERROR_MESSAGE){
    if(!isset($toCheck)){ //Verifies if an error exists

        //Checks for a microsoft error message
        if(isset($error)){
            die($description);
        }
        die(DEFAULT_ERROR_MESSAGE); //If there isnt a microsoft error, sends a default message
    }
}

?>