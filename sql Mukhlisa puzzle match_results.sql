
create database puzzles

use puzzles


Create Table Match_Result (
Team_1 Varchar(20),
Team_2 Varchar(20),
Result Varchar(20)
)

Insert into Match_Result Values('India', 'Australia','India');
Insert into Match_Result Values('India', 'England','England');
Insert into Match_Result Values('SouthAfrica', 'India','India');
Insert into Match_Result Values('Australia', 'England',NULL);
Insert into Match_Result Values('England', 'SouthAfrica','SouthAfrica');
Insert into Match_Result Values('Australia', 'India','Australia');


select * from Match_Result
select *, match_played-match_won-match_tied as match_lost from(
select a.Team_1,count(*) as match_played, b. match_won, isnull(c.match_tied,0) as match_tied from(
select Team_1 from Match_Result
union all 
select team_2 from Match_Result) as A
inner join
(
select team_1 ,count(result) as match_won from Match_Result
group by Team_1) as b on b.Team_1=a.Team_1
--group by a.Team_1, b.match_won
left join  (select *,count(*) as match_tied from (SELECT Team_1 FROM Match_ResultWHERE Result IS NULLUNION ALLSELECT Team_2 FROM Match_ResultWHERE Result IS NULL	) as dv6	group by dv6.Team_1) as C    on C.Team_1 = A.Team_1	group by A.team_1,B.match_won,C.match_tied) A




