with users_addresses as (
    select distinct shipping_address_id, NK_shipping_address_id from {{ ref('stg_orders') }}
),

stg_addresses as (
    select * from {{ ref('stg_addresses') }}
),

final as (
    select 
        u.shipping_address_id,
        u.NK_shipping_address_id,
        a.address,
        a.zipcode,
        a.zipcode_type,
        a.primary_city,
        a.county,
        a.county_fips,
        a.state,
        a.country,
        a.latitude,
        a.estimated_population,
        a.density


    from users_addresses u left join stg_addresses a on u.shipping_address_id = a.address_id
)

select * from final