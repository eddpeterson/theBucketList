# What's DONE: 
* Add todo, with title, due date, status (not a dropdown)
* Drop todo in one of the categories:personal, family, friends, work, social 
* Allow users to change the sorting and persist it in the datastore
* Allow user to rename the todo by double clicking on it
* Improve todo rename functionality by adding: Cancel button + Esc key and Save buttone + Enter key
* Add unit test for title validation and add appropriate error handling in jquery rename functionality
* Got test coverage > 95%
* Jquery drag and drop testing 

# TODO:

## Beautifying
* Add blueprint css
* Add effects when moving todo from one list to another
* Add this nice datetime gem that translated words to dates

## Become socially aware
* Use facebook, twitter to authorize
* List facebook, twitter, etc. friends todos (use capped collections)
* Timeline to integrate with Facebook and show not only past, bit future

## Defered
* Allow user to rename the todo by showing "rename" button when mouse over
* Allow user to set status of a todo from none to active, completed wen mouse over
* Allow users to remove item on mouse over and show confirmation
* Have to look how to place external plugin js and css assets. Maybe something missing in configs because I upgraded from rails 3.1.rc to 3.1
