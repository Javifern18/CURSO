with dim_day_parts as (
    select
         
        to_time('00:00:00') as time_of_day,
        'night' as day_part,
        'A partir de las 22h hasta las 6h' as day_part_description

        {% for i in range(0,24) %}
            {% if i in range(6,14) %}
                union
                select dateadd(hour,{{i}},to_time('00:00:00')),'morning','A partir de las 6h hasta las 14h'
            {% elif i in range(14,22) %}
                union
                select dateadd(hour,{{i}},to_time('00:00:00')),'afternoon','A partir de las 14h hasta las 22h'                     
            {% else %}
                union
                select dateadd(hour,{{i}},to_time('00:00:00')),'night','A partir de las 22h hasta las 6h'
            {% endif %}
        {% endfor %}
),

dim_day_parts_id as (
    select
        hour(time_of_day) as day_part_id,
        time_of_day,
        day_part,
        day_part_description
    
    from dim_day_parts
)

select * from dim_day_parts_id order by time_of_day