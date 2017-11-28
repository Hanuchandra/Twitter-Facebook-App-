<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<style>
    div {
      background-color: #3B5998;
      width: 455px;
      border: 10px red;
      padding: 5px;
      margin: 5px;
    }
    
    .button {
    background-color: #3B5998;
    border: none;
    color: white;
    padding: 10px 42px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    }
  </style>

<title>Tweter Home page</title>
<div> <center> <h2 style="color:white;" id="fb-welcome"></h2> </center> </div>
<br/>




<table >
  <tr>
    <th class="button" ><a style="color:white;" id="tweetLink">Tweet</a></th>
    <th class="button" ><a style="color:white;" href="/friendspage">Friends Page</a></th> 
    <th class="button" ><a style="color:white;" href="/toptweets">Top Tweets</a></th>
  </tr>
</table>
<br/>
<div> <center> <h3 style="color:white;" id="hdr">Twitter Home page</h3> </center> </div>


</head>
<body>
	 <script>
     	 window.fbAsyncInit = function() {
			FB.init({
				appId : '1127369400727359',
				xfbml : true,
				version : 'v2.9'
			});

			function onLogin(response) {
				if (response.status == 'connected') {
					FB.api('/me?fields=first_name,last_name', function(data) {
						var welcomeBlock = document.getElementById('fb-welcome');
						welcomeBlock.innerHTML = 'Hello, ' + data.first_name+' '+ data.last_name + '!'+'<br/>'+"Welcome to Twitter";
						
					    document.getElementById("tweetLink").href="/tweet?sndName="+data.first_name+' '+ data.last_name; 
					});

					/* FB.api('/me?fields=last_name', function(data) {
						var welcomeBlock = document
								.getElementById('fb-welcome');
						welcomeBlock.innerHTML = welcomeBlock.innerHTML
								+ '  last name= ' + data.last_name + '!';
					}); */

					/* FB.api('/me?fields=birthday', function(data) {
						var welcomeBlock = document
								.getElementById('fb-welcome');
						welcomeBlock.innerHTML = welcomeBlock.innerHTML
								+ '  Your Age is , '
								+ (2017 - parseInt(data.birthday.toString()
										.substring(6, 10))).toString() + '!';
					}); */

				} else {
					var welcomeBlock = document.getElementById('fb-welcome');
					welcomeBlock.innerHTML = 'Cant get data ' + response.status + '!';
				}
			}

			FB.getLoginStatus(function(response) {
				// Check login status on load, and if the user is
				// already logged in, go directly to the welcome message.
				console.log('getLoginStatus .... ');

				if (response.status == 'connected') {
					console.log('connected .... ');
					onLogin(response);
				} else {
					// Otherwise, show Login dialog first.
					console.log('Not connected .... ');
					FB.login(function(response) {
						onLogin(response);
					}, {
						scope : 'user_friends, email, user_birthday'
					});
				}
			});

			console.log('logPageView .... ');
			FB.AppEvents.logPageView();

		};

		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>


	 <!-- <div class="fb-like" data-share="true" data-width="450"	data-show-faces="true"></div> -->
</body>
</html>