### Olympics-History-Analysis-SQL Portfolio Project

There are two datasets containing 120 years of Olympic history:

1. athletes – Contains information about all athletes who participated in the Olympics.

2. athlete_events – Contains details of all Olympic events held over the years. (athlete_id in this table refers to the id column in the athletes table.)

### Tasks – Import these datasets into any SQL platform and answer the following questions:

1. Which team has won the maximum number of gold medals over the years?

2. For each team, display the total silver medals won and the year in which they won the most silver medals.
(Output: team, total_silver_medals, year_of_max_silver)

3. Which athlete has won the most gold medals, among those who have only ever won gold (never silver or bronze)?

4. For each year, identify the athlete(s) who won the most gold medals.
(Output: year, athlete name(s), number of golds; in case of a tie, return comma-separated names)

5. Identify the event and year in which India won its first gold, first silver, and first bronze medal.
(Output: medal, year, event)

6. Find athletes who have won a gold medal in both Summer and Winter Olympics.

7. Find athletes who have won a gold, silver, and bronze medal in a single Olympics.
(Output: athlete name, year)

8. Identify athletes who have won gold medals in three consecutive Summer Olympics in the same event, considering only Olympics held from 2000 onwards (i.e., every 4 years starting from 2000).
(Output: athlete name, event name)
