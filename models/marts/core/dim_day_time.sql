with seconds as (
   select
        1 as second

        {% for i in range(0,60) %}
        union
        select {{i}}

        {% endfor %}
),

minutes as (
   select
        1 as minute

        {% for i in range(0,60) %}
        union
        select {{i}}

        {% endfor %}
),

hours as (
   select
        1 as hour

        {% for i in range(0,24) %}
        union
        select {{i}}

        {% endfor %}
),

time_of_day as (
        select
                to_time(concat(hour,':',minute,':',second)) as time_of_day 

        from seconds cross join minutes cross join hours order by hour, minute, second
),

time_of_day_id as (
        select
                hour(time_of_day)*24*60+minute(time_of_day)*60+second(time_of_day) as time_of_day_id,
                time_of_day

        from time_of_day
)

select * from time_of_day_id