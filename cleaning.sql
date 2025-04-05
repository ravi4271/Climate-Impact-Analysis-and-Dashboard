-- Create a combined table

Create table "Climate Change"."Combined Data" as
select * from "Climate Change"."Australia"
union
select * from "Climate Change"."Brazil"
union
select * from "Climate Change"."Canada"
union
select * from "Climate Change"."Germany"
union
select * from "Climate Change"."India"
union
select * from "Climate Change"."South Africa"
union
select * from "Climate Change"."United States"

-- Check for duplicates

SELECT "Record ID"
FROM "Climate Change"."Combined Data"
group by "Record ID"
having count(*) > 1;

SELECT distinct "Country"
FROM "Climate Change"."Combined Data"

-- Update the country

update "Climate Change"."Combined Data"
set "Country" = 'India'
where "Country" = 'Inda';

-- Check for null values

select *
from "Climate Change"."Combined Data"
where "Record ID" IS NULL
or "Date" IS NULL
or "Country" IS NULL

or "City" IS NULL
or "Temperature" IS NULL
or "Humidity" IS NULL
or "Precipitation" IS NULL
or "Air Quality Index" IS NULL
or "Extreme Weather Events" IS NULL
or "Climate Classification" IS NULL
or "Climate Zone" IS NULL
or "Biome Type" IS NULL
or "Heat Index" IS NULL
or "Wind Speed" IS NULL
or "Wind Direction" IS NULL
or "Season" IS NULL
or "Population Exposure" IS NULL
or "Economic Impact Estimate" IS NULL
or "Infrastructure Vulnerability Score" IS NULL;

-- Update Population Exposure

update "Climate Change"."Combined Data"
set "Population Exposure" = 5275135
where "Record ID" = 'aus_1338';

-- Update City

update "Climate Change"."Combined Data"
set "City" = 'Toronto'
where "Record ID" = 'cnd_227';
