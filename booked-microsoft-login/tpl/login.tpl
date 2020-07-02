{*
Copyright 2011-2020 Nick Korbel

This file is part of Booked Scheduler.

Booked Scheduler is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Booked Scheduler is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Booked Scheduler.  If not, see <http://www.gnu.org/licenses/>.
*}
{include file='globalheader.tpl'}

<div id="page-login">
	<script type="text/javascript" src="https://alcdn.msauth.net/lib/1.2.1/js/msal.js" integrity="sha384-9TV1245fz+BaI+VvCjMYL0YDMElLBwNS84v3mY57pXNOt6xcUYch2QLImaTahcOP" crossorigin="anonymous"></script>
    <script type="text/javascript">
      if(typeof Msal === 'undefined')document.write(unescape("%3Cscript src='https://alcdn.msftauth.net/lib/1.2.1/js/msal.js' type='text/javascript' integrity='sha384-m/3NDUcz4krpIIiHgpeO0O8uxSghb+lfBTngquAo2Zuy2fEF+YgFeP08PWFo5FiJ' crossorigin='anonymous'%3E%3C/script%3E"));
    </script>

	{if $ShowLoginError}
		<div id="loginError" class="alert alert-danger">
			{translate key='LoginError'}
		</div>
	{/if}

    {if $EnableCaptcha}
        {validation_group class="alert alert-danger"}
        {validator id="captcha" key="CaptchaMustMatch"}
        {/validation_group}
    {/if}

    {if $Announcements|count > 0}
        <div id="announcements" class="col-sm-8 col-sm-offset-2 col-xs-12">
        {foreach from=$Announcements item=each}
            <div class="announcement">{$each->Text()|html_entity_decode|url2link|nl2br}</div>
        {/foreach}
        </div>
    {/if}

	<div class="col-md-offset-3 col-md-6 col-xs-12 ">
		<form role="form" name="login" id="login" class="form-horizontal" method="post"
			  action="{$smarty.server.SCRIPT_NAME}">
			<div id="login-box" class="col-xs-12 default-box">
				<div class="col-xs-12 login-icon">
					{html_image src="$LogoUrl?2.6" alt="$Title"}
				</div>
				{if $ShowUsernamePrompt}
					<div class="col-xs-12">
						<div class="input-group margin-bottom-25">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
							<input type="text" required="" class="form-control"
								   id="email" {formname key=EMAIL}
								   placeholder="{translate key=UsernameOrEmail}"/>
						</div>
					</div>
				{/if}

				{if $ShowPasswordPrompt}
					<div class="col-xs-12">
						<div class="input-group margin-bottom-25">
							<span class="input-group-addon">
							<i class="glyphicon glyphicon-lock"></i>
							</span>
							<input type="password" required="" id="password" {formname key=PASSWORD}
								   class="form-control"
								   value="" placeholder="{translate key=Password}"/>
						</div>
					</div>
				{/if}

                {if $EnableCaptcha}
                    <div class="col-xs-12">
                        <div class="margin-bottom-25">
                        {control type="CaptchaControl"}
                        </div>
                    </div>
                {else}
                    <input type="hidden" {formname key=CAPTCHA} value=""/>
                {/if}

				{if $ShowUsernamePrompt &&  $ShowPasswordPrompt}
				<div class="col-xs-12">
					<button type="submit" class="btn btn-large btn-primary  btn-block" name="{Actions::LOGIN}"
							value="submit">{translate key='LogIn'}</button>
					<input type="hidden" {formname key=RESUME} value="{$ResumeUrl}"/>
				</div>
				{/if}

				{if $ShowUsernamePrompt &&  $ShowPasswordPrompt}
				<div class="col-xs-12 {if $ShowRegisterLink}col-sm-6{/if}">
					<div class="checkbox">
						<input id="rememberMe" type="checkbox" {formname key=PERSIST_LOGIN}>
						<label for="rememberMe">{translate key=RememberMe}</label>
					</div>
				</div>
				{/if}

                {if $ShowRegisterLink}
                    <div class="col-xs-12 col-sm-6 register">
                    <span class="bold">{translate key="FirstTimeUser?"}
                    <a href="{$RegisterUrl}" {$RegisterUrlNew}
                       title="{translate key=Register}">{translate key=Register}</a>
                    </span>
                    </div>
                {/if}

				<div class="clearfix"></div>

				{if $AllowGoogleLogin && $AllowFacebookLogin}
					{assign var=socialClass value="col-sm-12 col-md-4"}
				{else}
					{assign var=socialClass value="col-sm-12"}
				{/if}

				{if $AllowGoogleLogin}
					<div class="{$socialClass} social-login" id="socialLoginGoogle">
						<a href="https://accounts.google.com/o/oauth2/v2/auth?scope=email%20profile&state={$GoogleState}&redirect_uri=https://www.social.twinkletoessoftware.com/googleresume.php&response_type=code&client_id=531675809673-3sfvrchh6svd9bfl7m55dao8n4s6cqpc.apps.googleusercontent.com">
							<img src="img/external/btn_google_signin_dark_normal_web.png" alt="Sign in with Google"/>
						</a>
					</div>
				{/if}
				{if $AllowFacebookLogin}
					<div class="{$socialClass} social-login" id="socialLoginFacebook">
						<a href="https://www.social.twinkletoessoftware.com/fblogin.php?protocol={$Protocol}&resume={$ScriptUrlNoProtocol}/external-auth.php%3Ftype%3Dfb%26redirect%3D{$ResumeUrl}">
							<img style="max-height:42px" src="img/external/btn_facebook_login.png" alt="Sign in with Facebook"/>
						</a>
					</div>
				{/if}
				<!--http://localhost/booked/WebServices/MicrosoftLogin/microsoftLogin.php-->
				<div class="{$socialClass} social-login" >
					<a href="https://login.microsoftonline.com/consumers/oauth2/v2.0/authorize?
					client_id=38447a9d-9422-4a24-9a45-6be935c4de35
					&response_type=code
					&redirect_uri=http://localhost/booked/WebServices/MicrosoftLogin/microsoftProfile.php
					&response_mode=query
					&scope=user.read openid profile
					&state=12345">
					<img style="max-height:42px " src="img/external/office-logo.png" alt="Sign in with Microsoft"/>
				</div>
			</div>
			<div id="login-footer" class="col-xs-12">
				{if $ShowForgotPasswordPrompt}
					<div id="forgot-password" class="col-xs-12 col-sm-6">
						<a href="{$ForgotPasswordUrl}" {$ForgotPasswordUrlNew} class="btn btn-link pull-left-sm"><span><i
										class="glyphicon glyphicon-question-sign"></i></span> {translate key='ForgotMyPassword'}</a>
					</div>
				{/if}
				<div id="change-language" class="col-xs-12 col-sm-6">
					<button type="button" class="btn btn-link pull-right-sm" data-toggle="collapse"
							data-target="#change-language-options"><span><i class="glyphicon glyphicon-globe"></i></span>
						{translate key=ChangeLanguage}
					</button>
					<div id="change-language-options" class="collapse">
						<select {formname key=LANGUAGE} class="form-control input-sm" id="languageDropDown">
							{object_html_options options=$Languages key='GetLanguageCode' label='GetDisplayName' selected=$SelectedLanguage}
						</select>
					</div>
				</div>
			</div>


		</form>
	</div>
</div>

{setfocus key='EMAIL'}

{include file="javascript-includes.tpl"}

<!-- importing app scripts (load order is important) -->
    <script type="text/javascript" src="./authConfig.js"></script>
    <script type="text/javascript" src="./graphConfig.js"></script>
    <script type="text/javascript" src="./ui.js"></script>
    <script type="text/javascript" src="./authRedirect.js"></script>   
    <!--<script type="text/javascript" src="./authPopup.js"></script>-->
    <script type="text/javascript" src="./graph.js"></script>

<script type="text/javascript">
	var url = 'index.php?{QueryStringKeys::LANGUAGE}=';
	$(document).ready(function () {
		$('#languageDropDown').change(function () {
			window.location.href = url + $(this).val();
		});

		var langCode = readCookie('{CookieKeys::LANGUAGE}');

		if (!langCode)
		{
			langCode = (navigator.language+"").replace("-", "_").toLowerCase();

			var availableLanguages = [{foreach from=$Languages item=lang}"{$lang->GetLanguageCode()}",{/foreach}];
			if (langCode !== "" && langCode != '{$SelectedLanguage|lower}') {
				if (availableLanguages.indexOf(langCode) !== -1)
				{
					window.location.href = url + langCode;
				}
			}
		}
	});
</script>
{include file='globalfooter.tpl'}