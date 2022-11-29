with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2019-01-01' as date)",
        end_date="dateadd(day, 1, current_date())"
    )
    }}

),

dim_date as (
    select
        year(date_day)*10000+month(date_day)*100+day(date_day) as date_id,
        year(date_day) as year,
        month(date_day) as month,
        day(date_day) as day 

    from date_spine
)

select * from dim_date



/*
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
*/