# What's DONE: 
* Add todo, with title, due date, status (not a dropdown)
* Drop todo in one of the categories:personal, family, friends, work, social 
* Allow users to change the sorting and persist it in the datastore
* Allow user to rename the todo by double clicking on it
* Improve todo rename functionality by adding: Cancel button + Esc key and Save buttone + Enter key
* Add unit test for title validation and add appropriate error handling in jquery rename functionality
* Got test coverage > 95%
* Jquery drag and drop testing 
* Remove forcing users to select frame and due date when adding a new todo.
* Place new todo adding under each frame
* Provide timeline view for user to add todo. The idea of concentrating on current next 10 months and next 10+ years.
* Beautifying: Add blueprint css
* Introduce status done / undone for todos in Timeline 

# TODO:

# instead provide two different views
* On the top of the page under Timeline link show percentage of done todos and when clicking on it take user to timeline
* Allow user to set due_date in Timeline view

## Become socially aware
* Use facebook, twitter to authorize
* List facebook, twitter, etc. friends todos (use capped collections)
* Timeline to integrate with Facebook and show not only past, but future

## Design
* It needs to be warm
* Add icons to Personal, Family, Friends, Work, Social
* Emphasize those frames, that have more items than others
* While draging, make it visible where it will be placed and add animation when placing item in todo list (like in pudding)

## Defered
* Allow user to rename the todo by showing "rename" button when mouse over
* Allow user to set status of a todo from none to active, completed wen mouse over
* Allow users to remove item on mouse over and show confirmation
* Have to look how to place external plugin js and css assets. Maybe something missing in configs because I upgraded from rails 3.1.rc to 3.1
