with dim_day_parts as (
    select 
        to_time('00:00:00') as hora,
        'night' as day_part

        {% for i in range(0,13) %}
            {% if i in range(0,7) %}
                union
                select dateadd(hour,{{i}},to_time('00:00:00')),'night'             
            {% else %}
                union
                select dateadd(hour,{{i}},to_time('00:00:00')),'morning'
            {% endif %}
        {% endfor %}
        
        {% for i in range(13,24) %}
            {% if i in range(13,20) %}
                union
                select dateadd(hour,{{i}},to_time('00:00:00')),'afternoon'             
            {% else %}
                union
                select dateadd(hour,{{i}},to_time('00:00:00')),'evening'
            {% endif %}
        {% endfor %}
)

select * from dim_day_parts order by hora