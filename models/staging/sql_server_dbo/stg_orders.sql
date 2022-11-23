with
    base_orders as (
        select * from {{ ref("base_orders") }}
),

    seed_shipping_service_description as (
        select * from {{ ref("seed_shipping_service_description") }}
),

    final as (
        select *
            from base_orders o join seed_shipping_service_description s
                on o.shipping_service = s.shipping_service
)

select * from final
