CREATE TABLE IF NOT EXISTS d_date ( ID bigint NOT NULL GENERATED ALWAYS AS IDENTITY, date_value DATE, date_hour INTEGER NOT NULL, date_desc VARCHAR(20) NOT NULL, day_name VARCHAR(10) NOT NULL, month_name VARCHAR(20) NOT NULL, day_of_week_num INTEGER NOT NULL, day_of_date INTEGER NOT NULL, day_of_month INTEGER NOT NULL, day_of_year INTEGER NOT NULL, PRIMARY KEY(ID));

CREATE TABLE IF NOT EXISTS d_direction (ID bigint GENERATED ALWAYS AS IDENTITY, direction_name VARCHAR(20) NOT NULL, PRIMARY KEY(ID));

CREATE TABLE IF NOT EXISTS d_status (ID bigint GENERATED ALWAYS AS IDENTITY, status_desc VARCHAR(20) NOT NULL, PRIMARY KEY(ID));

CREATE TABLE IF NOT EXISTS d_sensor (ID bigint GENERATED ALWAYS AS IDENTITY, sensor_name VARCHAR(20) NOT NULL, sensor_desc VARCHAR(20) NOT NULL, installation_date date NOT NULL, d_direction1_id bigint not null, d_direction2_id bigint not null, d_status_id bigint not null, latitude numeric NOT NULL, longitude numeric NOT NULL, location VARCHAR2(150),
PRIMARY KEY(ID),
CONSTRAINT d_sensor_direction1_id_fk FOREIGN KEY(d_direction1_id) REFERENCES d_direction(ID),
CONSTRAINT d_sensor_direction2_id_fk FOREIGN KEY(d_direction2_id) REFERENCES d_direction(ID),
CONSTRAINT d_sensor_status_id_fk FOREIGN KEY(d_status_id) REFERENCES d_status(ID));

CREATE TABLE IF NOT EXISTS f_sensor_activity (ID bigint GENERATED ALWAYS AS IDENTITY, d_sensor_id BIGINT NOT NULL, activity_date DATE NOT NULL, note VARCHAR2(1000), 
PRIMARY KEY(ID),
CONSTRAINT f_sen_activity_sensor_id_fk FOREIGN KEY(d_sensor_id) REFERENCES d_sensor(ID));

CREATE TABLE IF NOT EXISTS f_hourly_pedes_count (ID bigint GENERATED ALWAYS AS IDENTITY, d_date_id bigint not null, d_sensor_id bigint not null, pedestrian_counts bigint not null, 
PRIMARY KEY(ID),
CONSTRAINT f_hourly_pedes_date_id_fk FOREIGN KEY(d_date_id) REFERENCES d_date(ID),
CONSTRAINT f_hourly_pedes_sensor_id_fk FOREIGN KEY(d_sensor_id) REFERENCES d_sensor(ID));