--- Routes query for 2016
--- Figure out how to rank this by most rides
--- Create a generic view
create temporary view Routes11 as
SELECT CONCAT(start_station_id, '-', end_station_id) AS Route_ID, date_part('year', start_time) as bike_year, count(start_time) qty_of_trips, start_station.latitude AS start_latitude, start_station.longitude AS start_longitude, end_station.latitude AS end_latitude, end_station.longitude AS end_longitude, start_station.name as Start_Name, end_station.name as End_name
FROM citibike_2016
JOIN citibike_stations AS start_station ON citibike_2016.start_station_id = start_station.id
JOIN citibike_stations AS end_station ON citibike_2016.end_station_id = end_station.id
GROUP by 1, 2, 4, 5, 6, 7, 8, 9;

select Route_ID, qty_of_trips, bike_year, start_longitude, start_latitude, end_longitude, end_latitude, start_name, end_name,
	dense_rank () over(partition by bike_year order by qty_of_trips desc) trips_score
from Routes11
order by bike_year, trips_score
limit 10;


select count(start_time)
from citibike_2016
order by 1 desc
limit 100;


select concat(Start_station_id, '-', end_station_id), count(start_time)
from citibike_2016
group by 1
order by 2 desc
limit 100;


select count(start_time), concat(start_station_id, '-', end_station_id), date_part ('year', start_time),
	case
		when start_time <= '2016-01-31 23:59:59' then 'January'
		when start_time <= '2016-02-29 23:59:59' then 'February'
		when start_time <= '2016-03-31 23:59:59' then 'March'
		when start_time <= '2016-04-30 23:59:59' then 'April'
		when start_time <= '2016-05-31 23:59:59' then 'May'
		when start_time <= '2016-06-30 23:59:59' then 'June'
		when start_time <= '2016-07-31 23:59:59' then 'July'
		when start_time <= '2016-08-31 23:59:59' then 'August'
		when start_time <= '2016-09-30 23:59:59' then 'September'
		when start_time <= '2016-10-31 23:59:59' then 'October'
		when start_time <= '2016-11-30 23:59:59' then 'November'
		when start_time <= '2016-12-31 23:59:59' then 'December'
		when start_time <= '2017-01-31 23:59:59' then 'January'
		when start_time <= '2017-02-28 23:59:59' then 'February'
		when start_time <= '2017-03-31 23:59:59' then 'March'
		when start_time <= '2017-04-30 23:59:59' then 'April'
		when start_time <= '2017-05-31 23:59:59' then 'May'
		when start_time <= '2017-06-30 23:59:59' then 'June'
		when start_time <= '2017-07-31 23:59:59' then 'July'
		when start_time <= '2017-08-31 23:59:59' then 'August'
		when start_time <= '2017-09-30 23:59:59' then 'September'
		when start_time <= '2017-10-31 23:59:59' then 'October'
		when start_time <= '2017-11-30 23:59:59' then 'November'
		when start_time <= '2017-12-31 23:59:59' then 'December'
		when start_time <= '2018-01-31 23:59:59' then 'January'
		when start_time <= '2018-02-28 23:59:59' then 'February'
		when start_time <= '2018-03-31 23:59:59' then 'March'
		when start_time <= '2018-04-30 23:59:59' then 'April'
		when start_time <= '2018-05-31 23:59:59' then 'May'
		when start_time <= '2018-06-30 23:59:59' then 'June'
		when start_time <= '2018-07-31 23:59:59' then 'July'
		when start_time <= '2018-08-31 23:59:59' then 'August'
		when start_time <= '2018-09-30 23:59:59' then 'September'
		when start_time <= '2018-10-31 23:59:59' then 'October'
		when start_time <= '2018-11-30 23:59:59' then 'November'
		when start_time <= '2018-12-31 23:59:59' then 'December'
		when start_time <= '2019-01-31 23:59:59' then 'January'
		when start_time <= '2019-02-28 23:59:59' then 'February'
		when start_time <= '2019-03-31 23:59:59' then 'March'
		when start_time <= '2019-04-30 23:59:59' then 'April'
		when start_time <= '2019-05-31 23:59:59' then 'May'
		when start_time <= '2019-06-30 23:59:59' then 'June'
		when start_time <= '2019-07-31 23:59:59' then 'July'
		when start_time <= '2019-08-31 23:59:59' then 'August'
		when start_time <= '2019-09-30 23:59:59' then 'September'
		when start_time <= '2019-10-31 23:59:59' then 'October'
		when start_time <= '2019-11-30 23:59:59' then 'November'
		when start_time <= '2019-12-31 23:59:59' then 'December'
		else null
		end as Seasonality
from(
Select *
	from public.citibike_2016
	union all
Select *
	from public.citibike_2017
	union all
Select *
	from public.citibike_2018
	union all
Select *
	from public.citibike_2019) as t1
full join citibike_stations on t1.start_station_id = citibike_stations.id
where date_part ('year', start_time) = '2019'
group by 2, 3, 4
order by 1 desc
limit 10;

select id
from citibike_stations
except
select start_station_id
from citibike_2016

select count(bike_id)
from citibike_2016
group by 2
order by 1 desc
limit 100;





create temporary view tableseason1 as
select count(start_time) Trips, concat(start_station_id, '-', end_station_id) Route_ID, date_part ('year', start_time) as years, 
	case
		when start_time <= '2016-01-31 23:59:59' then 'January'
		when start_time <= '2016-02-29 23:59:59' then 'February'
		when start_time <= '2016-03-31 23:59:59' then 'March'
		when start_time <= '2016-04-30 23:59:59' then 'April'
		when start_time <= '2016-05-31 23:59:59' then 'May'
		when start_time <= '2016-06-30 23:59:59' then 'June'
		when start_time <= '2016-07-31 23:59:59' then 'July'
		when start_time <= '2016-08-31 23:59:59' then 'August'
		when start_time <= '2016-09-30 23:59:59' then 'September'
		when start_time <= '2016-10-31 23:59:59' then 'October'
		when start_time <= '2016-11-30 23:59:59' then 'November'
		when start_time <= '2016-12-31 23:59:59' then 'December'
		end as Seasonality
from public.citibike_2016
join citibike_stations on citibike_2016.start_station_id = citibike_stations.id
group by 2,3,4
order by 1 desc;



Select Route_ID, Trips, years, Seasonality, dense_rank () over(partition by years order by Trips desc) trips_score
from tableseason
where trips_score <= 10
group by 1, 2, 3, 4




Select date_part('week', start_time) as Time, count(bike_id) as Trips
from citibike_2016

group by 1
order by 1, 2 desc
limit 100;

Select date_part('day', start_time) as Time, count(bike_id) as Trips
from citibike_2016
group by 1
order by 1, 2 desc;


Select date_part('hour', start_time) as Time, count(bike_id) as Trips
from citibike_2016
group by 1
order by 1, 2 desc
limit 100;



SELECT AVG(DATE DIFF('minute', start_time, stop_time)) as avg_duration
FROM citibike_2016

Select stop_time - start_time as duration, bike_id
from citibike_2016
where (stop_time - start_time) < '00:00:00'::interval
limit 100;





---------------- 2017 data
create temporary view Routes17 as
SELECT CONCAT(start_station_id, '-', end_station_id) AS Route_ID, date_part('year', start_time) as bike_year, count(start_time) qty_of_trips, start_station.latitude AS start_latitude, start_station.longitude AS start_longitude, end_station.latitude AS end_latitude, end_station.longitude AS end_longitude, start_station.name as Start_Name, end_station.name as End_name
FROM citibike_2017 cbs17
JOIN citibike_stations AS start_station ON cbs17.start_station_id = start_station.id
JOIN citibike_stations AS end_station ON cbs17.end_station_id = end_station.id
GROUP by 1,2, 4, 5, 6, 7, 8, 9;

select Route_ID, qty_of_trips, bike_year, start_longitude, start_latitude, end_longitude, end_latitude, start_name, end_name,
	dense_rank () over(partition by bike_year order by qty_of_trips desc) trips_score
from Routes17
order by bike_year, trips_score
limit 10;












-------------  2018 data

create temporary view Routes18 as
SELECT CONCAT(start_station_id, '-', end_station_id) AS Route_ID, date_part('year', start_time) as bike_year, count(start_time) qty_of_trips, start_station.latitude AS start_latitude, start_station.longitude AS start_longitude, end_station.latitude AS end_latitude, end_station.longitude AS end_longitude, start_station.name as Start_Name, end_station.name as End_name
FROM citibike_2018 cbs18
JOIN citibike_stations AS start_station ON cbs18.start_station_id = start_station.id
JOIN citibike_stations AS end_station ON cbs18.end_station_id = end_station.id
GROUP by 1,2, 4, 5, 6, 7, 8, 9;

select Route_ID, qty_of_trips, bike_year, start_longitude, start_latitude, end_longitude, end_latitude, start_name, end_name,
	dense_rank () over(partition by bike_year order by qty_of_trips desc) trips_score
from Routes18
order by bike_year, trips_score
limit 10;














------------- 2019 data

create temporary view Routes120 as
SELECT CONCAT(start_station_id, '-', end_station_id) AS Route_ID, date_part('month', start_time) as bike_month, count(start_time) qty_of_trips, start_station.latitude AS start_latitude, start_station.longitude AS start_longitude, end_station.latitude AS end_latitude, end_station.longitude AS end_longitude, start_station.name as Start_Name, end_station.name as End_name
FROM citibike_2019 cbs19
JOIN citibike_stations AS start_station ON cbs19.start_station_id = start_station.id
JOIN citibike_stations AS end_station ON cbs19.end_station_id = end_station.id
GROUP by 1,2, 4, 5, 6, 7, 8, 9;



select *
from (
select Route_ID, qty_of_trips, bike_month, start_name, end_name,
	dense_rank () over(partition by bike_month order by qty_of_trips desc) trips_score
from Routes120) as t1
where trips_score <= 10
group by 1, 2, 3, 4, 5, 6
order by qty_of_trips desc
limit 10;










select count(start_time), end_station_id
from citibike_2019
group by 2
order by 1 desc
limit 10;

select count(start_time), start_station_id
from citibike_2019
group by 2
order by 1 desc
limit 10;

---- Create a view for Ranking the most popular routes


Select date_part('hour', start_time) as Time, count(bike_id) as Trips, coalesce(user_type, 'Unknown')
from (
SELECT *
FROM citibike_2016
union all
SELECT *
FROM citibike_2017
union all
SELECT *
FROM citibike_2018
union all
SELECT *
FROM citibike_2019) as table1
JOIN citibike_stations ON table1.start_station_id = citibike_stations.id
GROUP BY 1, 3
order by 1
limit 1000;




----------------------------------------
select end_station_id, count(start_time), date_part('year', start_time) as year
from (
Select *
	from public.citibike_2016
	union all
Select *
	from public.citibike_2017
	union all
Select *
	from public.citibike_2018
	union all
Select *
	from public.citibike_2019) as t1
group by 1, 3
order by 2 desc
limit 1000;


SELECT count(start_time), 
    start_station_id, 
    b1.longitude AS start_station_longitude, 
    b1.latitude AS start_station_latitude, 
    end_station_id, 
    b2.longitude AS end_station_longitude, 
    b2.latitude AS end_station_latitude
FROM 
    citibike_2016 AS tablea
    JOIN citibike_stations AS b1 ON tablea.start_station_id = b1.id
    JOIN citibike_stations AS b2 ON tablea.end_station_id = b2.id
group by 2,3,4,5,6,7
limit 1000;




Create temporary view t12 as
Select *
from (
SELECT date_part('year', start_time) bike_year, START_STATION_ID, COUNT(START_STATION_ID) qty_trips_made
FROM citibike_2016
GROUP BY START_STATION_ID, bike_year
union all
SELECT date_part('year', start_time) bike_year, START_STATION_ID, COUNT(START_STATION_ID) qty_trips_made
FROM citibike_2017
GROUP BY START_STATION_ID, bike_year
union all
SELECT date_part('year', start_time) bike_year, START_STATION_ID, COUNT(START_STATION_ID) qty_trips_made
FROM citibike_2018
GROUP BY START_STATION_ID, bike_year
union all
SELECT date_part('year', start_time) bike_year, START_STATION_ID, COUNT(START_STATION_ID) qty_trips_made
FROM citibike_2019
GROUP BY 1,2) as t1
JOIN public.citibike_stations stations on stations.id = t1.start_station_id
order by 1;

select *
from(
	select bike_year, start_station_id,	qty_trips_made, name, latitude, longitude,
		dense_rank () over(partition by bike_year order by qty_trips_made desc) trips_score
	from t12
	order by bike_year, trips_score
) as t3
order by 1;




SELECT count(gender),
	case
		when gender = 1 then 'Male'
		when gender = 2 then 'Female'
		else null
		end as gender_cat
FROM public.citibike_2016
group by 2
ORDER BY 2;


select bike_year, max(number_trips), start_station_id
	from(
select start_station_id, count(start_time) number_trips, date_part('year', start_time) as bike_year
	from (
Select *
	from public.citibike_2016
	union all
Select *
	from public.citibike_2017
	union all
Select *
	from public.citibike_2018
	union all
Select *
	from public.citibike_2019	) as t1
group by 1, 3
order by 2 desc ) as t2
group by 1, 3
order by 2 desc
limit 1000;



select start_station_id, count(start_time)
from (
Select *
	from public.citibike_2016
	union all
Select *
	from public.citibike_2017
	union all
Select *
	from public.citibike_2018
	union all
Select *
	from public.citibike_2019) as t1
group by 1
order by 2 desc
limit 1000;



select count(distinct start_station_id)
from bluebikes_2016


select count(distinct start_station_id)
from bluebikes_2017


select count(distinct start_station_id)
from bluebikes_2018


select count(distinct start_station_id)
from bluebikes_2019



Select start_station_id
	from public.citibike_2016
	except
Select start_station_id
	from public.citibike_2017
	except
Select start_station_id
	from public.citibike_2018
	except
Select start_station_id
	from public.citibike_2019
Limit 1000;



select distinct id
from citibike_stations


select name
from citibike_stations