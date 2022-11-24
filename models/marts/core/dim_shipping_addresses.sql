with users_addresses as (
    select distinct user_id, address_id from {{ ref('stg_orders') }} order by user_id, address_id
),

stg_addresses as (
    select * from {{ ref('stg_addresses') }}
),

final as (
    select {{ dbt_utils.surrogate_key(['user_id', 'u.address_id']) }} as shipping_address_id,
    user_id,
    u.address_id,
    zipcode,
    address,
    primary_city,
    city_name,
    county_name,
    state,
    country,
    latitude,
    longitude,
    population,
    density,
    _fivetran_deleted,
    _fivetran_synced


    from users_addresses u join stg_addresses a on u.address_id = a.address_id
)

select * from final