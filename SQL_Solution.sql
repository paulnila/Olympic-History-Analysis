select * from [dbo].[athletes]

select * from [dbo].[athlete_events]

--1 which team has won the maximum gold medals over the years.

select top 1  team,count(distinct event) as cnt from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Gold'
group by team
order by cnt desc



--2 for each team print total silver medals and year in which they won maximum silver medal..output 3 columns
-- team,total_silver_medals, year_of_max_silver



with cte as(select a.team, av.year, count(distinct event) as silver_medals,rank() over(partition by team order by count(distinct event) desc) rnk
from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where medal = 'Silver'
group by a.team, av.year
)

select team, sum(silver_medals) as total_silver_medals, max(case when rnk = 1 then year end) as year_of_max_silver

from cte
group by team


--3 which player has won maximum gold medals  amongst the players 
--which have won only gold medal (never won silver or bronze) over the years


with cte as (
select name,medal
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id)
select top 1 name , count(1) as no_of_gold_medals
from cte 
where name not in (select distinct name from cte where medal in ('Silver','Bronze'))
and medal='Gold'
group by name
order by no_of_gold_medals desc



--4 in each year which player has won maximum gold medal . Write a query to print year,player name 
--and no of golds won in that year . In case of a tie print comma separated player names.


with cte as( select year, name, count(medal) gold_cnt , rank() over(partition by year order by count(medal) desc) rnk

from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where medal = 'Gold'
group by year, name
)
select year, gold_cnt, STRING_AGG(name, ',')
from cte
where rnk=1
group by year, gold_cnt



--5 in which event and year India has won its first gold medal,first silver medal and first bronze medal
--print 3 columns medal,year,sport


with cte as(select event, year, medal,rank() over(partition by medal order by year asc) rnk

from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where team ='India' and medal = 'Silver')



,cte2 as(select event, year, medal,rank() over(partition by medal order by year) rnk

from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where team ='India' and medal = 'Gold')



,cte3 as(select event, year, medal,rank() over(partition by medal order by year) rnk

from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where team ='India' and medal = 'Bronze')


select distinct medal,year, event 
from cte c

where c.rnk=1 
union 
select medal,year, event 
from cte2 

where rnk=1
union
select medal,year, event 
from cte3

where rnk=1


--6 find players who won gold medal in summer and winter olympics both.


select  name , count(distinct season)
from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where medal = 'Gold' 
group by name
having count(distinct season)=2


--7 find players who won gold, silver and bronze medal in a single olympics. print player name along with year.



select  name, year
from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where medal  != 'NA' 
group by name, year
having count(distinct medal) = 3


--8 find players who have won gold medals in consecutive 3 summer olympics in the same event . Consider only olympics 2000 onwards. 
--Assume summer olympics happens every 4 year starting 2000. print player name and event name.


with cte as(select name, event, medal, year
from [dbo].[athletes] a
join [dbo].[athlete_events] av
on a.id = av.athlete_id
where season = 'Summer' and medal = 'Gold' and year >= 2000)

,cte2 as(select name, event, year, lag(year,1) over(partition by name,event order by year) prev_year,
lead(year,1) over(partition by name,event order by year) next_year
from cte)


select name, event
from cte2 
where year- prev_year = 4 and next_year-year = 4
