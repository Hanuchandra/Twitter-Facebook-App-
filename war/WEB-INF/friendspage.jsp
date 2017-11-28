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
<title>Friends Page</title>
<div> <center> <h2 style="color:white;"  id="fb-welcome"></h2> </center> </div>
<br/>
<table  border: 1px solid black">
  <tr>
    <th class="button"  ><a style="color:white;" id="tweetLink">Tweet</a></th>
    <th class= "button" ><a style="color:white;" href="/friendspage">Friends Page</a></th> 
    <th class="button"  ><a style="color:white;" href="/toptweets">Top Tweets</a></th>
  </tr>
</table>
<br/>
<div > <center> <h3 style="color:white;" id="hdr">Twitter Friends Page</h3> </center> </div>


</head>
<body id="body">
	<input type="hidden" id="sndName" name="sndName" value=">" >
	<!-- <img id="img" src="" alt="HTML5 Icon" width="64" height="64"> -->
	<br>

	 <script>
		//console.log('${usertweetsCount}');
		 var usertweets = '${usertweets}';
		//console.log(usertweets);
		usertweetsArray = usertweets.split("-----")
		for (var i = 0; i < usertweetsArray.length-1; i++) {
			//console.log(usertweetsArray[i]);
			//console.log(document.getElementById('tt').innerHTML);
			//document.getElementById('tt').innerHTML = document.getElementById('tt').innerHTML +usertweets[i].split('--')[0]+'  =====>  '+usertweets[i].split('--')[1]+'<br>';
		} 
		
	 window.fbAsyncInit = function() {
			FB.init({
				appId : '1127369400727359',
				xfbml : true,
				version : 'v2.9'
			});

			function onLogin(response) {
				if (response.status == 'connected') {
					FB.api('/me?fields=first_name,last_name,picture', function(data) {
					    //console.log(data);
						//console.log(data.first_name + " " + data.last_name);
					    //console.log(data.picture.data.url);
					    //document.getElementById('img').src= data.picture.data.url
					    //console.log(document.getElementById('img').src);
					    var image = document.createElement("img");
					    var imageParent = document.getElementById("body");
					    image.id = "Owner Image";
					    image.className = "class";
					    image.src = data.picture.data.url;
					    imageParent.appendChild(image);
					    
					    var t = document.createTextNode(" " + data.first_name + " " + data.last_name);
					    imageParent.appendChild(t);
					    
					    linebreak = document.createElement("br");
					    imageParent.appendChild(linebreak);
					    
					    if (usertweets.includes(data.first_name + " " + data.last_name)) {
							for (var i = 0; i < usertweetsArray.length-1; i++) {
								if (usertweetsArray[i].includes(data.first_name + " " + data.last_name)){
									var a = document.createElement('a');
									var msg = document.createTextNode(usertweetsArray[i].split("--")[2]);
								    msg.textIndent="100px";
									a.appendChild(msg)
									a.title = msg;
									a.href = "https://fb-tweeter.appspot.com/display_tweet?id="+usertweetsArray[i].split("--")[0];
									a.target="_blank";
									imageParent.appendChild(document.createTextNode( '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0' ));
								    imageParent.appendChild(a);
								    lb = document.createElement("br");
								    imageParent.appendChild(lb);
								}
							} 
						    lb = document.createElement("br");
						    imageParent.appendChild(lb);
					    }
					    
						var welcomeBlock = document.getElementById('fb-welcome');
						welcomeBlock.innerHTML = 'Hello... ' + data.first_name+' '+ data.last_name ;
					    document.getElementById("tweetLink").href="/tweet?sndName="+data.first_name+' '+ data.last_name; 
						var sndName= document.getElementById("sndName")
						if (sndName){
							console.log('The sender is ok ');
							sndName.value = data.first_name+' '+ data.last_name
						}else{
							console.log('The sender is ok ');
						}
					});

					FB.api('/me/friends?fields=first_name,last_name,picture', function(data){
					    //console.log(data);
					    
					    for (var i in data.data) {
						    //console.log(data.data[i].first_name + " " + data.data[i].last_name);
						    //console.log(data.data[i].picture.data.url);
						    
						    var image = document.createElement("img");
						    var imageParent = document.getElementById("body");
						    image.id = "id"+i;
						    image.className = "class";
						    image.src = data.data[i].picture.data.url;
						    imageParent.appendChild(image);
						    
						    var t = document.createTextNode(" " + data.data[i].first_name + " " + data.data[i].last_name);    
						    imageParent.appendChild(t);

						    linebreak = document.createElement("br");
						    
						    imageParent.appendChild(linebreak);
						    
						    if (usertweets.includes(data.data[i].first_name + " " + data.data[i].last_name)) {
								for (var k = 0; k < usertweetsArray.length-1; k++) {
									if (usertweetsArray[k].includes(data.data[i].first_name + " " + data.data[i].last_name)){
										var a = document.createElement('a');
									    var msg = document.createTextNode(usertweetsArray[k].split("--")[2]);
									    msg.textIndent="100px";
										a.appendChild(msg)
										a.title = msg;
										a.href = "https://fb-tweeter.appspot.com/display_tweet?id="+usertweetsArray[k].split("--")[0];
										a.target="_blank";
										imageParent.appendChild(document.createTextNode( '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0' ));
									    imageParent.appendChild(a);
									    lb = document.createElement("br");
									    imageParent.appendChild(lb);
									}
								} 
							    lb = document.createElement("br");
							    imageParent.appendChild(lb);
						    }

				        }
					    
					}, {scope: 'user_friends'});
					
					
				}
			
				else {
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
</body>
</html>