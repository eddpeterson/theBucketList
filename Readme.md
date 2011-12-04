# TODO: 100 hours initially estimated

*   BUG: Rename button is not accessible for longer texts when Rename is wrapped on the second line. Bug is reproducible only if Rename is the only word on last line. Should place it on the left side as it was for Basecamp # 2 hours
    
    Use jquery ui trash icon in front
    
    http://stackoverflow.com/questions/5626830/make-ui-icon-appear-on-same-line-as-other-text-within-li
    
*   Timeline to integrate with Facebook and show not only past, but future # 16 hours
    
    https://developers.facebook.com/docs/beta/opengraph/
     
*   Use design created by Alexander # 16 hours

*   Accept terms of use for the website. Read about different software licenses # 8 hours

*   Setup production email sender used by exception notificaitons and test it # 1 hour
    
    >:user_name            => ENV['app_email_sender']
    
    >:password             => ENV['app_email_sender_password']

*   Test production on all browsers and on Mac and Windows

*   [Three state solution: Regular, Blank, Error](http://gettingreal.37signals.com/ch09_Three_State_Solution.php) # Not planned, but super importants. Need to be done after the complete design is in place
    
    For blank when moving to  goals add Watermark for new goal.
    
    For Timeline tell that there is no goals added and display special link to add goals. Also during timeline is visible.
    
    For Friends page show that there are no frineds, but allow to invite facebook friends

*   Create video

    Search for Royalty free music
    http://www.beatsuite.com/
    Panjemt dziesmu no albuma
 
*   Create production apps for facebook, heroku and map 101todos dns # 2 hours

## Security # 8 hours

*   protect_from_forgery

*   sql injection

## Defered

*   Fix friends request specs, by actually logging in with one of test users?
    
    Moxy could help? http://jondot.github.com/moxy/

*   Refactor spec/controllers/todos_controller_spec.rb to bring code coverage back to > 95% and fix pending tests # 16 hours 

*   Check inline editing as it is done in best_in_place demo on github and rename functionality with once click

*   Draw center of attention circle in separate view (distribution among frames). Historgram?

*   Show next/previous 25 in goals view. Need to think of a concept. Not sure it is good idea, how to manage multiple past goals in Timeline is also a question.

*   When adding new goal use .effect("highlight")

*   Allow friends to facebook like specific goals

*   List facebook friends goals with the same concept as your timeline? # 8 hours estimated, but this functionality should be covered by facebook

*   Timeline should display horizontal line with multiple dots on it or should it be facebook timeline responsibility?

*   While dragging, make it visible where it will be placed and add animation when placing item in todo list (like in pudding)

*   If user has already granted permission to application in facebook and is singed in to facebook in browser, there should be no login required (facebook cookies?)

*   Wall page displaying latest updates on what is happening with all the stuf, show which of my friends have recently joined the site and their goals added, completed (a lot of logic needs to be built around that to avoid too much data traffic)

*   use pjax?

*   Strike through goals that are done and place them at the bottom of priority

*   Fix pending test

*   Logout from application is not in sync with actual Facebook login status

*   Test for select date functionality (jasmine?)

*   Allow user to rename the todo by showing "rename" button when mouse over

*   Have to look how to place external plugin js and css assets. Maybe something missing in configs because I upgraded from rails 3.1.rc to 3.1

*   Limit querying and displaying todos to maximum N number (need to think more about it)

*   Use capped collections in future for facebook friends features, but it requires architecture change
