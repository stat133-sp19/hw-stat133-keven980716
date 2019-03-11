## GSW Shot Data Dictionary

-----------

### About data

* There are totally **5** `.csv` files in the `data` folder which are shots data of Golden State Warriors' players *Andre Iguodala*, *Draymond Green*, *Kevin Durant*, *Klay Thompson* and *Stephen Curry* in the season 2016-2017. 

* There are totally **13** different kinds of variables, more detailed information are displayed in the following.

* The data source comes from [here](https://github.com/ucb-stat133/stat133-hws/tree/master/data).

### Additional information

|Variable    | Description |Data Type             |
|:---------|:----------------------------------------|:---------------|
|team_name| the team to which the player belongs |  Character |
|game_date| the date when the game was played | Character | 
|season |the season in which the games were played | Integer| 
|period| the time period when the shot occurred   (1,2,3,4) | Integer | 
|minutes_remaining|the amount of minutes remained in this period when the shot occurred (0-11)| Integer |
|seconds_remaining| the amount of seconds remained in this minute when the shot occurred (0-59) | Integer |
|shot_made_flag| whether this shot was made ("n","y") | Character |
|action_type| basketball moves used by the player to try this shot| Character |
|shot_type| the type of shot  | Character |
|shot_distance| distance to the basket (measured in feet) | Integer |
|opponent | the team which the palyer were playing against with | Character |
|x| court coordinates (x-axis, measured in inches) where a shot occurred  | Integer |
|y| court coordinates (y-axis, measured in inches) where a shot occurred  | Integer |







