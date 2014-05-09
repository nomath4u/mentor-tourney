#!/user/peteoss/aoi/bin/perl
####################################################################################
# Program : Sports Tournament Records
# Author : Chauncey Yan
# Description : Prompt user to query what they want to see and insert new records.
# Revision : 0.1 
# Date : May 7th
####################################################################################
# Initialization: ARGV,gridDB,query
#################################################################################### 
if (not defined $ARGV[0]) {
# this variable is undefined
$ARGV[0]="";
}
$dbuser = 'cyan';
$dbpass = 'cyan_password';

####################################################################################
# Main
####################################################################################
if (($ARGV[0] eq "-i") && (length($ARGV[1]) == 9 )){
	InsertR();
} elsif ($ARGV[0] eq "-s" ){
	ShowR();
} else {
	system("clear");
	print "Welcome to Sports Tournament Records program!\nSupporting options:\n";
	print "--> -h -- Help page (NULL)\n";
	print "--> -s -- Show specified records mode (Prompt)\n";
	print "--> -i PlayerID,OpponentID,DateID,SportID,WLID -- Insert mode (Supervisor only)\n";
	$sa_query="select Ply.ID, Ply.PlayerName, Opp.PlayerName as Opponent, Date.Date, Sports.ID SportID, SportName, WL.WL 
	from Records 
	inner join Sports on Records.Sport=Sports.ID 
	inner join Players as Ply on Ply.ID=Records.Player 
	inner join Players as Opp on Records.Opponent=Opp.ID 
	inner join Date on Date.ID=Records.Date 
	inner join WL on WL.ID=Records.WL";
	system("/wv/pevtools/bin/pex_wrap mysql -h pexqa-db.wv.mentorg.com -u $dbuser -p$dbpass -D cyan -e '$sa_query'");
}

#################################################################################### 
# sub declarations
# InsertR
#################################################################################### 
sub InsertR {
	# query define
	$i_query="insert into cyan.Records(Player,Opponent,Date,Sport,WL) values($ARGV[1]);";
	# execute the mysql database
	system("clear");
	system("/wv/pevtools/bin/pex_wrap mysql -h pexqa-db.wv.mentorg.com -u $dbuser -p$dbpass -e '$i_query'");
	print "$i_query\nInserted\n";
	$sa_query="select Ply.PlayerName, Opp.PlayerName as Opponent, Date.Date, SportName, WL.WL 
	from Records 
	inner join Sports on Records.Sport=Sports.ID 
	inner join Players as Ply on Ply.ID=Records.Player 
	inner join Players as Opp on Records.Opponent=Opp.ID 
	inner join Date on Date.ID=Records.Date 
	inner join WL on WL.ID=Records.WL";
	system("/wv/pevtools/bin/pex_wrap mysql -h pexqa-db.wv.mentorg.com -u $dbuser -p$dbpass -D cyan -e '$sa_query'");
}
#################################################################################### 
# sub declarations
# ShowR
#################################################################################### 
sub ShowR {
	system("clear");
	print "Show specified records mode.\n";
	while(1){
		print "Which player(s) you are willing to show?\n";
		$sap_query="select PlayerName from Players";
		system("/wv/pevtools/bin/pex_wrap mysql -h pexqa-db.wv.mentorg.com -u $dbuser -p$dbpass -D cyan -e '$sap_query'");
		print "(seperate your choices by non alphanumeric character. \"all\" for all players)\n";
		chomp ($players=<STDIN>);
		print "Press ENTEY to look for $players. ";
		$en=<STDIN>;
		if ( $en eq "\n"){
			last;
		}
	}
	while(1){
		print "Which sport(s) you are willing to show? \n";
		$sas_query="select SportName from Sports";
		system("/wv/pevtools/bin/pex_wrap mysql -h pexqa-db.wv.mentorg.com -u $dbuser -p$dbpass -D cyan -e '$sas_query'");
		print "(seperate your choices by non alphanumeric character. \"all\" for all Sports)\n";
		chomp ($sports=<STDIN>);
		print "Press ENTEY to look for $sports. ";
		$en=<STDIN>;
		if ( $en eq "\n"){
			last;
		}
	}
#	while(1){
#		print "Which date(s) you are willing to show? (seperate them by ','. \"all\" for all dates)\n";
#		chomp ($dates=<STDIN>);
#		print "Press ENTEY to look for $dates. ";
#		$en=<STDIN>;
#		if ( $en eq "\n"){
#			last;
#		}
#	}
#################################################################################### 
# query the database by calling the function
#################################################################################### 
#print "Players : $players\nSports : $sports\n";
	$s_query="select Ply.PlayerName, Opp.PlayerName as Opponent, Date.Date, SportName, WL.WL 
	from Records 
	inner join Sports on Records.Sport=Sports.ID 
	inner join Players as Ply on Ply.ID=Records.Player 
	inner join Players as Opp on Records.Opponent=Opp.ID 
	inner join Date on Date.ID=Records.Date 
	inner join WL on WL.ID=Records.WL 
	where ( Ply.PlayerName=\"Champ\"";
	if ( $players ne "all" ){
		while ($players =~ /(\w+)/g) {
			$s_query.=" or Ply.PlayerName=\"$1\"";
		}
		$s_query.=" ) and ( SportName=\"Kickass\"";
	} else {
		$s_query = substr($s_query, 0, length($s_query)-30);
		$s_query.="where ( SportName=\"Kickass\"";
	}
	if ( $sports ne "all" ){
		while ($sports =~ /(\w+)/g) {
			#print "Matched sport is $1 in $sports\n";
			$s_query.=" or SportName=\"$1\"";
		}
		$s_query.=" )";
	} else {
		$s_query = substr($s_query, 0, length($s_query)-28);
	}

	system("clear");
	system("/wv/pevtools/bin/pex_wrap mysql -h pexqa-db.wv.mentorg.com -u $dbuser -p$dbpass -D cyan -e '$s_query'");
		
}


