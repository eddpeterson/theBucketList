# DONE: 
## Basic operations to manage todos
* Add todo, with title, due date, status (not a dropdown)
* Drop todo in one of the categories:personal, family, friends, work, social 
* Allow users to change the sorting and persist it in the datastore
* Allow user to rename the todo by double clicking on it
* Improve todo rename functionality by adding: Cancel button + Esc key and Save buttone + Enter key
* Add unit test for title validation and add appropriate error handling in jquery rename functionality
* Got test coverage > 95%

# TODO:

## Technical debt
* Catch up on how to test jquery dudes and then refactor mercilessly views, javascript, models, controller, tests with jasmine

## BUGS
* Remove is added to title of todo when double clicking
* Modal message box is crappy and buggy - find another one
* Remove public/assets library and figure out how to use jquery plugins in rails 3.1

## Beautifying
* Add blueprint css
* Add effects when moving todo from one list to another
* Add this nice datetime gem that translated words to dates

## Become socially aware
* Use facebook, twitter to authorize
* List facebook, twitter, etc. friends todos (use capped collections)


## Defered
* Allow user to rename the todo by showing "rename" button when mouse over
* Allow user to set status of a todo from none to active, completed wen mouse over
* Allow users to remove item on mouse over and show confirmation
