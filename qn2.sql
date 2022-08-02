--Top 10 (most pedestrians) locations by month
SELECT month_name, sensor_desc, ranking FROM
(SELECT agg.sensor_desc, agg.month_name, row_number() over(partition by agg.month_name order by agg.total_pedestrians desc) ranking
(SELECT t2.sensor_desc, t3.month_name, sum(t1.pedestrian_counts) total_pedestrians
FROM f_hourly_pedes_count T1, d_sensor T2, d_date T3
WHERE t1.d_date_id=t3.id AND 
t1.d_sensor_id=t2.id) agg) 
WHERE ranking<11
order by 1,3;