with users_addresses as (
    select distinct user_id, address_id from {{ ref('stg_orders') }} order by user_id, address_id
),

stg_addresses as (
    select * from {{ ref('stg_addresses') }}
),

final as (
    select {{ dbt_utils.surrogate_key(['user_id', 'u.address_id']) }} as shipping_address_id,
    u.user_id,
    u.address_id,
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
    a.density,
    a._fivetran_synced


    from users_addresses u join stg_addresses a on u.address_id = a.address_id
)

select * from final