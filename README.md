####################################################################################
This is a program to keep track of our intern tournament data.
View this file in RAW or BLAME mode.
####################################################################################
Insert mode: 
####################################################################################
Using the command line arguments to insert subjects ID into database cyan.Records
Usage example:
perl /home/cyan/Desktop/programs/sportsTournamentRecorder/str.pl -i 1,2,1,0
The number repersent the following in order.
PlayerID(1-Ashley,2-Chauncey,3-Christopher,4-Sam)
OpponentID(same assignment as above)
SportID(1-Foosball,2-PingPong,3-Pool)
WinorLose(0-lose,1-win)


####################################################################################
Show data mode:
####################################################################################
Prompt the user with the player, sport and date selections
Usage example:
Show specified records mode.
Which player(s) you are willing to show?
+-------------+
| PlayerName  |
+-------------+
| Ashley      |
| Chauncey    |
| Christopher |
| Sam         |
+-------------+
(seperate your choices by non alphanumeric character. "all" for all players)
Christopher,Sam
Press ENTER to look for Christopher,Sam. 
Which sport(s) you are willing to show? 
+-----------+
| SportName |
+-----------+
| Foosball  |
| PingPong  |
| Pool      |
+-----------+
(seperate your choices by non alphanumeric character. "all" for all Sports)
Foosball,PingPong
Press ENTER to look for Foosball,PingPong.
+-------------+----------+------------+-----------+----+
| PlayerName  | Opponent | Date       | SportName | WL |
+-------------+----------+------------+-----------+----+
| Christopher | Chauncey | 2014-05-07 | PingPong  | L  |
| Christopher | Chauncey | 2014-05-07 | Foosball  | W  |
| Sam         | Ashley   | 2014-05-07 | Foosball  | W  |
| Sam         | Ashley   | 2014-05-07 | PingPong  | W  |
+-------------+----------+------------+-----------+----+
