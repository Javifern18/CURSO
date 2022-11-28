with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2019-01-01' as date)",
        end_date="dateadd(month, 1, current_date())"
    )
    }}

),

renamed as (
    select
        case 
        when month(date_month) between 1 and 9 then concat('0',month(date_month)::varchar)
        else month(date_month)::varchar
        end as month, 
        year(date_month) as year

    from date_spine
)

select
    concat(month,year) as id_fecha,
    month,
    year

from renamed