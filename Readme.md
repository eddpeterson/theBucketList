Control your own destiny!

TODO

Time: 07.11.2011 - ...

# What's DONE: 

# TODO: 100 hours 

* How to plant debugging messages for production # 2 hours
* Do not allow adding empty title goals in jQuery # 2 hours
* When changing date, should automatically move todo to appropriate category # 2 hours
* List facebook friends todos with the same concept as your timeline? # 8 hours
* Use seeds file to create test data # 2 hours
* Use design created by Alexander # 16 hours
* Accept terms of use for the website # 8 hours
* Refactor spec/controllers/todos_controller_spec.rb to bring code coverage back to > 95% # 16 hours
* http://railscasts.com/episodes/104-exception-notifications-revised # 2 hours
* Order todos in timeline view by due_date, but for past it should be descending so that on top you see the most recently finished items # 2 hours
* Automatically update goals completed percentage after 1. changing goals status, 2. adding new goal, 3. removing goal # 3 hours
* Friends page should contain list of friends using the site, with status of their accomplished goals (%), showing distribution among frames and see their timeline # 8 hours
* Timeline to integrate with Facebook and show not only past, but future # 16 hours

## BUGS 
* Rename button is not accessible for longer texts when Rename is wrapped on the second line. Bug is reproducible only if Rename is the only word on last line. Should place it on the left side as it was for Basecamp # 2 hours
* Rename functionality is buggy and need to create alternative # 4 hours


## Security # 8 hours
* protect_from_forgery
* sql injection



## Defered
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
