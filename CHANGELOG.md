## The Bucket List 1.1.0 (unreleased) ##

TODO

*   How to plant debugging messages for production # 2 hours estimated, took 30 minutes 
    
    >In code use:
    
    >>`logger.info "Create goal: #{params}"`
    
    >>`logger.debug "Create goal: #{params}"`
    
    >In environments/production.rb use:
    
    >>`config.log_level = :info`
    
    >>`config.log_level = :debug`
    
    >Check if the file size is not growing automatically

*   Use seeds file to create test data # 2 hours estimated, took 30 minutes

    >modify db/seeds.rb file
    
    >use `rake db:seed` and `rake db:reseed` commands

*   How do I view mongodb on production (Heroku). # 1 hour

    >from command line
    
    >`heroku run console`
    
    >`User.count`
    
    >`User.all[0].goals`

*   Exception handling in rails # 2 hours estimated, took 30 minutes
    
    >[Railscasts 104-exception-notifications-revised](http://railscasts.com/episodes/104-exception-notifications-revised)

*   Do not allow adding empty title goals in jQuery # 2 hours estimated, took 15 minutes, but no tests were added

*   Order todos in timeline view by due_date. Past goals sorted descending, Current and Future goals sorted ascending # 2 hours estimated, took 30 minutes

*   When changing date, should automatically move goal to appropriate category # 2 hours estimated, 3.5 hours done

*   Automatically update goals completed percentage by writing it to user field in db after # 3 hours estimated, 3h implemented
    
    1. changing goals status 
    
    2. adding new goal 
    
    3. removing goal 

*   Refine about text # 1 hour estimated, took 2 hours

*   Remove .live event and use new jQuery 1.7 .on event # Spent about 2 hours
    
    >http://rubydoc.info/gems/jquery-rails/1.0.18/frames
    
    >Get ridd of jquery ui in assets
    
    >Add jquery in application.js
    
    >`//= require jquery-ui`
    
    >http://stackoverflow.com/questions/8238553/i-updated-to-the-latest-jquery-rails-1-0-18-but-did-not-get-the-new-jquery

*   Add facebook like button to site on about page when user is logged in (instead of login view) # 1 hour
    
    >Test users:
    
    >Carol id: 100003030401022
    
    >David id: 100003038021110
    
    >Make Carol and David friends
    
    >https://graph.facebook.com/TEST_USER_1_ID/friends/TEST_USER_2_ID?access_token=<get carrols acces token>&method=post
    
    >After you need to login as David and accept the friendship
    
*   Should call user completed goals percentage only when user is logged in or when the form is being displayed. 

*   Facebook login should work automatically. Improve how login flow works. # Unplanned and worked already 10 hours
    
    >http://jessehowarth.com/2011/04/27/ajax-login-with-devise
    
    >http://stackoverflow.com/questions/5794926/login-with-devise-via-jquery-mobile
    
    >http://stackoverflow.com/questions/5081322/devise-asks-authentication-for-ajax-request
    
    >Remove omniauth sign in functionality from views

*   Put all javascript code to javascript files from facebook related functionality

*   If user is logged-in do not display Log in view

*   Need to update user name, email for new users and existing ones as well (because now new users will have only id and token fields)

*   Refactor FacebookDude to FacebookInfo

*   Friends page should contain list of friends using the site # 8 hours
    
    >with % of accomplished goals # 1 hour
    
    >with their photos # 2 hours
    
    >leading distribution among frames # could not get sparklines gem to run

*   Create changelog. See how other open source projects does it. # 2 hours

## The Bucket List 1.0.0  (July 25 - November 7, 2011) ##

Initial version of the Bucket List deployed in the cloud.
Helps organizing your life goals by framing your activities to personal, family, friends, work or social interests.
View your goals in time scale of past, current and future.
Use facebook to authorize through application and see your friends using the application.

*   Add todo, with title, due date, status (not a dropdown)

*   Drop todo in one of the categories:personal, family, friends, work, social 

*   Allow users to change the sorting and persist it in the datastore

*   Allow user to rename the todo by double clicking on it

*   Improve todo rename functionality by adding: Cancel button + Esc key and Save buttone + Enter key

*   Add unit test for title validation and add appropriate error handling in jquery rename functionality

*   Got test coverage > 95%

*   JQuery drag and drop testing 

*   Remove forcing users to select frame and due date when adding a new todo.

*   Place new todo adding under each frame

*   Provide timeline view for user to add todo. The idea of concentrating on current next 10 months and next 10+ years.

*   Beautifying: Add blueprint css

*   Introduce status done / undone for todos in Timeline 

*   On the top of the page under Timeline link show percentage of done todos and when clicking on it take user to timeline

*   For new todo set due_date to today + 10months

*   Allow user to set due_date when in timeline view 

*   Before continuing create feature branch for facebook

*   Use facebook to authorize

*   Refactor gui 
    
    >On left top only name of the website if logged in:
    >On middle top display links Goals, Timeline, Friends, About
    >On the right top display % goals completeness
    >If not logged in:
    >Merge middle, right top and dipslay facebook login button

*   When not logged in default page should be About, when logged in default page should be todos

*   Rename todos to goals

*   Bug when removing one item and then moving another item from that list to another list

*   Remove button should appear only when mouse over

*   Take out facebook applciation id and token not to be excluded from github

*   Depoloy to heroku

*   Contact Alexander about design
