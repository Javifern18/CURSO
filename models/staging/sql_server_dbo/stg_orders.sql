with
    base_orders as (
        select * from {{ ref("base_orders") }}
),

    seed_shipping_service_description as (
        select
            {{ dbt_utils.surrogate_key(['shipping_service_name', 'shipping_service_description']) }} as shipping_service_id
            ,shipping_service_name
            ,shipping_service_description 
        from {{ ref("seed_shipping_service_description") }}
),

    final as (
        select * exclude(shipping_service_name)
            from base_orders join seed_shipping_service_description
                on shipping_service = shipping_service_name
)

select * from final
