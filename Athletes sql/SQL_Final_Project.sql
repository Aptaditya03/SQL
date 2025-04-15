-- SQL PROJECT
use athelete_project;
-- 1. Show how many medal counts present for entire data
create table olympics(ID int,
 Name varchar(255),
 Sex varchar(255),
 Age int,
 Height int,
 Weight int,
Team varchar(255), 
NOC varchar(255), 
Games varchar(255),
Year int, 
Season varchar(255),
City varchar(255),
Sport varchar(255),
Event varchar(255),
Medal varchar(255));

describe olympics; 
show VARIABLES LIKE "secure_file_priv";

load data infile 'C:/ProgramData/MySQL/MySQL Server 9.0/Uploads/Athletes_cleaned.csv'
into table olympics
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- 1. Show how many medal counts present for entire data
select count(Medal) as medal_count from olympics
where Medal <> 'NoMedal';

-- 2. Show count of unique sports present in Olympics
select count(distinct Sport) as Unique_sport from olympics;

-- 3. Show how many different medals won by team India
select count(Medal) as medal_count,team,Medal from olympics
where Team = 'India' and Medal != 'NoMedal'
group by Medal;



-- 4. Show event wise medals won by India show from highest to lowest medals won in order
select Team,Medal,count(Medal) as Medal_count, Event from olympics
where Team = 'India' and Medal != 'NoMedal'
group by Event,Medal
order by Medal_count desc;  


-- 5. Show event wise medals won by India in order of year
select Team,Medal,count(Medal) as Medal_count,Year,Event from olympics
where Team = 'India' and Medal != 'NoMedal'
group by Year,Medal,Event
order by Year desc;  


-- 6. show country who won maximum medals.
select Team,count(Medal) as Medal_count from olympics
where Medal <> 'NoMedal'
group by Team
order by Medal_count desc
limit 1;

-- 7.show top 10 countries whowon gold
select Team,count(Medal) as Medal_count,Max(Medal) from olympics
where Medal <> 'NoMedal' and Medal = 'Gold'
group by Team,Medal
order by Medal_count desc
limit 10;


--  8. show in which year did United states won most gold medal
select Team,count(Medal) as Medal_count,Year from olympics
where Medal = 'Gold' and Team = 'United States'
group by Team,Medal,Year
order by Medal_count desc
limit 1;



-- 9. In which sports United States has most medals.
select Team,count(Medal) as Medal_count,Sport from olympics
where Medal <> 'NoMedal' and Team = 'United States'
group by Team,Sport
order by Medal_count desc
limit 1;


-- 10. Find top three players who won most medals along with their sports and country
select Team,count(Medal) as Medal_count,Sport,Name from olympics
where Medal <> 'NoMedal'  
group by Team,Sport,Name
order by Medal_count desc
limit 3;


-- 11. Find player with most gold medals in cycling along with his country.
select Team,count(Medal) as Medal_count,Sport,Name from olympics
where Medal = 'Gold' and Sport = 'Cycling'  
group by Team,Sport,Name
order by Medal_count desc
limit 1;


-- 12.Find player with most medals (Gold+Silver+Bronze) in Basketball also show his country.
SELECT Name, NOC, COUNT(Medal) AS MedalCount
FROM olympics
WHERE Sport = 'Basketball' AND (Medal = 'Gold' OR Medal = 'Silver' OR Medal = 'Bronze')
GROUP BY Name, NOC
ORDER BY MedalCount DESC
LIMIT 1;


-- 13. Find out the count of different medals of the top basketball player Teresa Edwards
SELECT Medal, COUNT(*) AS MedalCount
FROM olympics
WHERE Name = 'Teresa Edwards' AND Sport = 'Basketball'
GROUP BY Medal;


-- 14. Find out medals won by male,female each year , Export this data and plot graph in excel
SELECT Year, Sex, Medal, COUNT(*) AS MedalCount
FROM olympics
WHERE Sport = 'Basketball' AND (Medal = 'Gold' OR Medal = 'Silver' OR Medal = 'Bronze')
GROUP BY Year, Sex, Medal
ORDER BY Year, Sex, Medal;


