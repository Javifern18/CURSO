with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2019-01-01' as date)",
        end_date="cast('2022-01-01' as date)"
    )
    }}

)

select date_day from date_spine