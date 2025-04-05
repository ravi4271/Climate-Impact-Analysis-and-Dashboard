# Monthly Temperature Trends

SELECT TO_CHAR("Date", 'Month') AS Month_Name,
AVG("Temperature") AS Avg_Temperature
FROM "Climate Change"."Combined Data"
GROUP BY TO_CHAR("Date", 'Month'), EXTRACT(MONTH FROM "Date")
ORDER BY EXTRACT(MONTH FROM "Date");

-- Average temperature by country

SELECT "Country",
AVG("Temperature") AS Avg_Temperature
FROM "Climate Change"."Combined Data"

GROUP BY "Country"
ORDER BY Avg_Temperature DESC;

-- Extreme Weather Events by Month

SELECT TO_CHAR("Date", 'Month') AS Month_Name,
COUNT(*) AS Event_Count
FROM "Climate Change"."Combined Data"
WHERE "Extreme Weather Events" <> 'None'
GROUP BY TO_CHAR("Date", 'Month')
ORDER BY MIN("Date");

-- Country-wise Extreme Weather

SELECT "Country",
COUNT(*) AS Event_Count
FROM "Climate Change"."Combined Data"
WHERE "Extreme Weather Events" <> 'None'
GROUP BY "Country"
ORDER BY Event_Count DESC;

-- Extreme Weather Events by Temperature Range

SELECT
CASE
WHEN "Temperature" < 10 THEN 'Very Cold (<10°C)'
WHEN "Temperature" BETWEEN 10 AND 15 THEN 'Cold (10-15°C)'
WHEN "Temperature" BETWEEN 15 AND 20 THEN 'Moderate (15-20°C)'
WHEN "Temperature" BETWEEN 20 AND 25 THEN 'Warm (20-25°C)'
ELSE 'Hot (>25°C)'
END AS Temperature_Range,
"Extreme Weather Events",
COUNT(*) AS Event_Count
FROM "Climate Change"."Combined Data"
WHERE "Extreme Weather Events" <> 'None'
GROUP BY Temperature_Range, "Extreme Weather Events"
ORDER BY Temperature_Range, Event_Count DESC;

-- Which cities are experiencing extreme weather events this week and what are their
economic and population impacts?

select
"Country",
"City",
"Extreme Weather Events",
count(*) as "Event Type",
Round(avg("Temperature"), 1) as "Average Temperature",
sum("Population Exposure") as "Total Population Exposure",

sum("Economic Impact Estimate") as "Total Economic Impact",
round(avg("Infrastructure Vulnerability Score"), 0) as "Average Vulnerability"
from "Climate Change"."Combined Data"
where "Date" between '2025-03-03' and '2025-03-07'
and "Extreme Weather Events" != 'None'
group by "Country", "City", "Extreme Weather Events"
order by "Total Economic Impact" desc;

-- What are the top 5 cities with the highest air quality concerns and their associate risks?

select
"Country",
"City",
round(avg("Air Quality Index"), 0) as "Average AQI",
count(*) as "Days above 200 AQI",
SUM("Population Exposure") as "Total Population Exposure",
round(avg("Temperature"), 1) as "Average Temperature"
from "Climate Change"."Combined Data"
where "Date" between '2025-03-03' and '2025-03-07'
group by "Country", "City"
having avg("Air Quality Index") > 100
order by "Average AQI"
limit 5;

Which biome types are most risk from extreme weather events this week?
select
"Biome Type",
count(*) as "Total Records",
count(distinct concat("Country", "City")) as "Locations Affected",
count(case when "Extreme Weather Events" != 'None' then 1 end) as "Extreme Weather
Count",
STRING_AGG(DISTINCT "Extreme Weather Events", ', ') as "Event Types",
Round(avg("Temperature"), 1) as "Average Temperature",
sum("Economic Impact Estimate") as "Total Economic Impact Estimate",
Round(Avg("Infrastructure Vulnerability Score"), 0) as "Average Vulnerability"
from "Climate Change"."Combined Data"
where "Date" between '2025-03-03' and '2025-03-07'
group by "Biome Type"
