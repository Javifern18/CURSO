with stg_orders as (
    select
        shipping_service_id 
        ,shipping_service
        ,shipping_service_description
    
    from {{ ref('stg_orders') }}
)

select * from stg_orders