{% macro obtener_date_id(table, column) %}

with obtener_date_id as (
    select
        case 
        when day({{column}}) between 1 and 9 then concat('0',day({{column}})::varchar)
        else day({{column}})::varchar
        end as day,
        case 
        when month({{column}}) between 1 and 9 then concat('0',month({{column}})::varchar)
        else month({{column}})::varchar
        end as month, 
        year({{column}}) as year

    from {{table}}
)

select
    concat(day,month,year) as id_fecha

from obtener_date_id

{% endmacro %} 