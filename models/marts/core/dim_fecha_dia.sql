with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2019-01-01' as date)",
        end_date="dateadd(day, 1, current_date())"
    )
    }}

),

renamed as (
    select
        case 
        when day(date_day) between 1 and 9 then concat('0',day(date_day)::varchar)
        else day(date_day)::varchar
        end as day,
        case 
        when month(date_day) between 1 and 9 then concat('0',month(date_day)::varchar)
        else month(date_day)::varchar
        end as month, 
        year(date_day) as year

    from date_spine
)

select
    concat(day,month,year) as id_fecha,
    day,
    month,
    year

from renamed