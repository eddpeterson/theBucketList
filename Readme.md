# What's DONE: 
* Add todo, with title, due date, status (not a dropdown)
* Drop todo in one of the categories:personal, family, friends, work, social 
* Allow users to change the sorting and persist it in the datastore
* Allow user to rename the todo by double clicking on it
* Improve todo rename functionality by adding: Cancel button + Esc key and Save buttone + Enter key
* Add unit test for title validation and add appropriate error handling in jquery rename functionality
* Got test coverage > 95%
* JQuery drag and drop testing 
* Remove forcing users to select frame and due date when adding a new todo.
* Place new todo adding under each frame
* Provide timeline view for user to add todo. The idea of concentrating on current next 10 months and next 10+ years.
* Beautifying: Add blueprint css
* Introduce status done / undone for todos in Timeline 
* On the top of the page under Timeline link show percentage of done todos and when clicking on it take user to timeline
* For new todo set due_date to today + 10months
* Allow user to set due_date when in timeline view 
* Before continuing create feature branch for facebook
* Use facebook to authorize
* Refactor gui 
> On left top only name of the website
If logged in:
> On middle top display links Goals, Timeline, Friends, About
> On the right top display % goals completeness
If not logged in:
> Merge middle, right top and dipslay facebook login button
* When not logged in default page should be About, when logged in default page should be todos
* Rename todos to goals
* Bug when removing one item and then moving another item from that list to another list
* Remove button should appear only when mouse over
* Take out facebook applciation id and token not to be excluded from github

# TODO:

* Depoloy to heroku
* Accept terms of use for the website

* Refactor spec/controllers/todos_controller_spec.rb to bring code coverage back to > 95%
* http://railscasts.com/episodes/104-exception-notifications-revised

## Can we do it in parallel while I send for the design request?
* Detailed design specification
* List facebook friends todos with the same concept as your timeline? 
* Timeline to integrate with Facebook and show not only past, but future

## BUGS
* Do not allow adding empty title goals in jQuery
* When changing date, should automatically move todo to appropriate category
* Rename functionality is buggy and need to create alternative
* Rename button should appear when mouse over

## Design
* LOGO: Things I'd like to do before I kick the bucket
* Design needs to be warm and simple

### About page
* Should display facebook friends using the application if you are logged in to facebook
* Place for video
* Note that when user is logged in to facebook in browser, but not in application, he/she sees friends using website

### Goals page
* Add icons to Personal, Family, Friends, Work, Social (big icon on top and small icons near each of the goals)
* Add kind of recycle bin icon instead of Remove button
* Change "Add" button to something other? 
* Emphasize those frames, that have more items than others (if Friends have more goals than Work, it should be visible to user)

### Timeline page
* Use goals small icons
* Create status indicator (completed or not completed goal). Nice button that slides like here: http://www.heroku.com/pricing#0-0+shared


### N% goals completeness
* Like LinkedIn when you go to edit profile

### Jquery improvements
* While dragging, make it visible where it will be placed and add animation when placing item in todo list (like in pudding)
 


## Security
* protect_from_forgery
* sql injection



## Defered
* If user has already granted permission to application in facebook and is singed in to facebook in browser, there should be no login required (facebook cookies?)
* Wall page displaying latest updates on what is happening with all the stuf, show which of my friends have recently joined the site and their goals added, completed (a lot of logic needs to be built around that to avoid too much data traffic)
* Friends page should contain list of friends using the site, with status of their accomplished goals, showing distribution among frames and see their timeline
* use pjax?
* Strike through goals that are done and place them at the bottom of priority
* Fix pending test
* Use facebook login button, it has better UX 
  ? http://developers.facebook.com/docs/reference/javascript/FB.Event.subscribe/
* Logout from application is not in sync with actual Facebook login status

* Create video of how to use the system
* Test for select date functionality (jasmine?)
* Allow user to rename the todo by showing "rename" button when mouse over
* Allow user to set status of a todo from none to active, completed wen mouse over
* Allow users to remove item on mouse over and show confirmation
* Have to look how to place external plugin js and css assets. Maybe something missing in configs because I upgraded from rails 3.1.rc to 3.1
* Order todos in timeline view by due_date, but for past it should be descending so that on top you see the most recently finished items
* Limit querying and displaying todos to maximum N number (need to think more about it)
* Use capped collections in future for facebook friends features, but it requires architecture change
