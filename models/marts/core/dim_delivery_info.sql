with delivery_info as (
    select
        {{ dbt_utils.surrogate_key(['delivery_info', 'days_early','days_of_delay']) }} as delivery_info_id,          
        delivery_info,
        days_early,
        days_of_delay
    
    from {{ ref('order_status_snapshot') }}
)

select distinct * from delivery_info