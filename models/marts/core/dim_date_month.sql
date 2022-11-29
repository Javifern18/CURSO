with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2019-01-01' as date)",
        end_date="dateadd(month, 1, current_date())"
    )
    }}

),

dim_date_month as (
    select
        year(date_month)*100+month(date_month) as date_month_id,
        year(date_month) as year,
        month(date_month) as month

    from date_spine
)

select * from dim_date_month