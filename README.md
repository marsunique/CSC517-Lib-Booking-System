# README
## link
http://powerful-badlands-79365.herokuapp.com/
## Log In Account 
* Please do not delete 1@test.com & user@test.com. Thanks!)
* Pre-configured Admin:
  test@test.com
  Password:000000
* Admin:
  1@test.com 
  Password:000000
* User:
  user@test.com
  Password:000000

*Please Don't Delete These Three Accounts Above. If you want to test delete function, you can creat a new account and delete it. Thank You*
## Features
We design different UI for different types of user. The navigation bar on the top will display different menus for normal users and admins.
Authority control. Normal users and admins have different level of access to some actions, e.g. delete a user, add a room, view all users etc.
Following is the the detailed infomation.
### Admin
* One pre-configured admin. This admin cannot be deleted by other admins.
* Create admins and users.
* View all admins and users and their profile.
* Edit his own profile (access to edit other's profile is prohibited).
* Delete admins (except himself) and users.
* Edit profile and change password.
* Manage rooms (add, delete and show detail).
* View booking history of a user (Manage->Manage User).
* View booking history of a room (Manage->Manage Room).
* Book a room on behalf of a user or himself. Cancel a reservation if it has not started.

### Library Members (Normal User)
* View and edit profile.
* Search rooms.
* View and book a room.
* Cancel a reservation if it has not started.
* View own booking history (Room->My Booking History).

## Notice
* If admin books a room on behalf of a user, it would redirect to **All Book Histories** page instead of a specific record page directly.
* If a room was deleted, the future booking records would also be deleted, but the past records would be kept.
* If admin or user was delelted, the future booking records would also be delted, but the past records would be kept.
* In Search Room, you could submit any kind of requirements and any number of requirements, including room number, size and building.

## Version
* Ruby version: 2.3.0
* Rails version: 5.0.0.1

## Words In The End
This application still has some bugs and malfunction we are working on. If you find one, feel free to point it out.
If have any questions, you can reach us by **ddu3@ncsu.edu** and **ysun34@ncsu.edu**.
