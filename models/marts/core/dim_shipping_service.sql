with stg_orders as (
    select distinct
        ifnull(shipping_service_id,'0') as shipping_service_id
        ,ifnull(shipping_service_name,'No asignado') as shipping_service_name
        ,ifnull(shipping_service_description,'No asignado') as shipping_service_description
    
    from {{ ref('stg_orders') }}
)

select * from stg_orders