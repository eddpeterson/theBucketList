Initial version of the Bucket List deployed in the cloud.
Helps organizing your life goals by framing your activities to personal, family, friends, work or social interests.
View your goals in time scale of past, current and future.
Use facebook to authorize through application and see your friends using the application.

Time: 25.07.2011 - 07.11.2011
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
* Depoloy to heroku
* Contact Alexander about design
