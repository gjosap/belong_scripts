--Which location has most growth in last year
SELECT t3.sensor_desc FROM (
SELECT t2.sensor_desc, row_number() over(order by t2.avg_growth desc) ranking FROM
(SELECT t1.sensor_desc, AVG(t1.pedestrians_percentage_growth) avg_growth
FROM
(SELECT agg.day_of_year, agg.day_of_month, agg.sensor_desc, (agg.total_pedestrians - LAG (agg.total_pedestrians) OVER (ORDER BY agg.day_of_month))/LAG (agg.total_pedestrians) OVER (ORDER BY agg.day_of_month)*100 AS pedestrians_percentage_growth FROM
(SELECT t2.sensor_desc, t3.day_of_year, t3.day_of_month, sum(t1.pedestrian_counts) total_pedestrians
FROM f_hourly_pedes_count T1, d_sensor T2, d_date T3
WHERE t1.d_date_id=t3.id AND 
t1.d_sensor_id=t2.id AND
t3.day_of_year=extract(year from current_timestamp )-1) agg
order by 1,2) t1 
group by t1.sensor_desc) t2) t3
WHERE t3.ranking=1;