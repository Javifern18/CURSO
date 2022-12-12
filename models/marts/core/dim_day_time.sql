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
        1 as hour, 'prueba' as day_part, 'prueba2' as day_part_description

        {% for i in range(0,24) %}
                {% if i in range(6,14) %}
                        union
                        select {{i}},'morning','A partir de las 6h hasta las 14h'
                {% elif i in range(14,22) %}
                        union
                        select {{i}}, 'afternoon','A partir de las 14h hasta las 22h'                     
                {% else %}
                        union
                        select {{i}},'night','A partir de las 22h hasta las 6h'
                {% endif %}
        {% endfor %}
),

time_of_day as (
        select
                to_time(concat(hour,':',minute,':',second)) as time_of_day,
                day_part,
                day_part_description 

        from seconds cross join minutes cross join hours order by hour, minute, second
),

time_of_day_id as (
        select
                hour(time_of_day)*24*60+minute(time_of_day)*60+second(time_of_day) as time_of_day_id,
                time_of_day,
                day_part,
                day_part_description

        from time_of_day
)

select * from time_of_day_id