Control your own destiny!

TODO

Time: 07.11.2011 - ...

# What's DONE: 

# TODO: 100 hours initially estimated

* Use design created by Alexander # 16 hours
* Accept terms of use for the website. Read about different software licenses # 8 hours
* Setup production email sender used by exception notificaitons and test it # 1 hour
:user_name            => ENV['app_email_sender'],
:password             => ENV['app_email_sender_password'],


* Check inline editing as it is done in best_in_place demo on github and rename functionality with once click

* Test production on all browsers and on Mac and Windows
http://www.andismith.com/blog/2011/11/on-and-off/?utm_source=javascriptweekly&utm_medium=email

* Refactor spec/controllers/todos_controller_spec.rb to bring code coverage back to > 95% and fix pending tests # 16 hours 
* Fix friends request specs, by actually logging in with one of test users?
Moxy could help? http://jondot.github.com/moxy/

* Timeline to integrate with Facebook and show not only past, but future # 16 hours
https://developers.facebook.com/docs/beta/opengraph/

* Three state solution: Regular, Blank, Error
http://gettingreal.37signals.com/ch09_Three_State_Solution.php

* Create video
Search for Royalty free music
http://www.beatsuite.com/
Panjemt dziesmu no albuma

* Create production apps for facebook, heroku and map 101todos dns # 2 hours


* Jquery UI themese, how to include them in the rails 

## BUGS 
* Rename button is not accessible for longer texts when Rename is wrapped on the second line. Bug is reproducible only if Rename is the only word on last line. Should place it on the left side as it was for Basecamp # 2 hours
* Rename functionality is buggy and need to create alternative # 4 hours


## Security # 8 hours
* protect_from_forgery
* sql injection



## Defered
* Draw center of attention circle in separate view (distribution among frames). Historgram?
* Show next/previous 25 in goals view
* When adding new goal use .effect("highlight")
* Allow friends to facebook like specific goals
* List facebook friends goals with the same concept as your timeline? # 8 hours estimated, but this functionality should be covered by facebook
* Users could hack other users goals when logged in if they knew the ids
* Timeline should display horizontal line with multiple dots on it or should it be facebook timeline responsibility?
* While dragging, make it visible where it will be placed and add animation when placing item in todo list (like in pudding)
* If user has already granted permission to application in facebook and is singed in to facebook in browser, there should be no login required (facebook cookies?)
* Wall page displaying latest updates on what is happening with all the stuf, show which of my friends have recently joined the site and their goals added, completed (a lot of logic needs to be built around that to avoid too much data traffic)
* use pjax?
* Strike through goals that are done and place them at the bottom of priority
* Fix pending test
* Use facebook login button, it has better UX 
  ? http://developers.facebook.com/docs/reference/javascript/FB.Event.subscribe/
* Logout from application is not in sync with actual Facebook login status
* Update to new Omniauth http://intridea.com/2011/11/2/omniauth-1-0
* Create video of how to use the system
* Test for select date functionality (jasmine?)
* Allow user to rename the todo by showing "rename" button when mouse over
* Have to look how to place external plugin js and css assets. Maybe something missing in configs because I upgraded from rails 3.1.rc to 3.1
* Limit querying and displaying todos to maximum N number (need to think more about it)
* Use capped collections in future for facebook friends features, but it requires architecture change
