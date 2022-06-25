create table if not exists nyc_taxi (vendor_id string, pickup_datetime string, dropoff_datetime string, passenger_count int, trip_distance double, pickup_longitude double, pickup_latitude double, rate_code int, store_and_fwd_flag string, dropoff_longitude double, dropoff_latitude double, payment_type string, fare_amount double, surcharge double, mta_tax double, tip_amount double, tolls_amount double, total_amount double)
row format delimited
fields terminated by ','
stored as textfile
tblproperties('skip.header.line.count' = '1');
load data local inpath '/mnt/nyc_taxi_data_2014.csv' overwrite into table nyc_taxi;
create view if not exists nyc as select passenger_count as passenger_count, fare_amount as fare_amount, (tip_amount/total_amount) as tip_rate from nyc_taxi;
create view if not exists nyctaxi as select * from nyc where passenger_count>1 AND passenger_count<10;
select passenger_count, AVG(fare_amount), AVG(tip_rate) from nyctaxi group by passenger_count;