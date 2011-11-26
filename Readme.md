Control your own destiny!

TODO

Time: 07.11.2011 - ...

# What's DONE: 
* How to plant debugging messages for production # 2 hours estimated, took 30 minutes
Use 
logger.info "Create goal: #{params}"
logger.debug "Create goal: #{params}"
And in environments/production.rb use
config.log_level = :info
config.log_level = :debug
Check if the file size is not growing automatically
* Use seeds file to create test data # 2 hours estimated, took 30 minutes
modify db/seeds.rb file
use rake db:seed and rake db:reseed commands
* How do I view mongodb on production (Heroku). # 1 hour
from command line
heroku run console
User.count
User.all[0].goals
* http://railscasts.com/episodes/104-exception-notifications-revised # 2 hours estimated, took 30 minutes
* Do not allow adding empty title goals in jQuery # 2 hours estimated, took 15 minutes, but no tests were added
* Order todos in timeline view by due_date. Past goals sorted descending, Current and Future goals sorted ascending # 2 hours estimated, took 30 minutes
* When changing date, should automatically move goal to appropriate category # 2 hours estimated, 3.5 hours done
* Automatically update goals completed percentage by writing it to user field in db after 1. changing goals status, 2. adding new goal, 3. removing goal # 3 hours estimated, 3h implemented
* Refine about text # 1 hour estimated, took 2 hours
* Remove .live event and use new jQuery 1.7 .on event # Spent about 2 hours
http://rubydoc.info/gems/jquery-rails/1.0.18/frames
Get ridd of jquery ui in assets
Add jquery in application.js
//= require jquery-ui
http://stackoverflow.com/questions/8238553/i-updated-to-the-latest-jquery-rails-1-0-18-but-did-not-get-the-new-jquery
* Add facebook like button to site on about page when user is logged in (instead of login view) # 1 hour
Test users:
Carol id: 100003030401022
David id: 100003038021110
Make Carol and David friends
https://graph.facebook.com/TEST_USER_1_ID/friends/TEST_USER_2_ID?access_token=<get carrols acces token>&method=post
After you need to login as David and accept the friendship

# TODO: 100 hours initially estimated

* Facebook login should work automatically. Improve how login flow works. # Unplanned and worked already 4 hours

* Friends page should contain list of friends using the site # 8 hours
- with % of accomplished goals # 1 hour
- with their photos # 2 hours
- leading distribution among frames

* Use design created by Alexander # 16 hours
* Accept terms of use for the website # 8 hours
* Setup production email sender used by exception notificaitons and test it # 1 hour
:user_name            => ENV['app_email_sender'],
:password             => ENV['app_email_sender_password'],


* Test production on all browsers and on Mac and Windows
http://www.andismith.com/blog/2011/11/on-and-off/?utm_source=javascriptweekly&utm_medium=email

* Refactor spec/controllers/todos_controller_spec.rb to bring code coverage back to > 95% and fix pending tests # 16 hours 
* Timeline to integrate with Facebook and show not only past, but future # 16 hours
https://developers.facebook.com/docs/beta/opengraph/

* Should not allow hacking other user goals # 2 h

* Create video
Search for Royalty free music
http://www.beatsuite.com/

* Create production apps for facebook, heroku and map 101todos dns # 2 hours

* Show next/previous 25 in goals view

## BUGS 
* Should call user completed goals percentage only when user is logged in or when the form is being displayed. 
* Rename button is not accessible for longer texts when Rename is wrapped on the second line. Bug is reproducible only if Rename is the only word on last line. Should place it on the left side as it was for Basecamp # 2 hours
* Rename functionality is buggy and need to create alternative # 4 hours


## Security # 8 hours
* protect_from_forgery
* sql injection



## Defered
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
