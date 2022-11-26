with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2019-01-01' as date)",
        end_date="cast('2022-01-01' as date)"
    )
    }}

)

select date_month from date_spine