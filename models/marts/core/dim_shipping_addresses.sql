with users_addresses as (
    select distinct user_id, address_id from {{ ref('stg_orders') }} order by user_id, address_id
),

stg_addresses as (
    select * from {{ ref('stg_addresses') }}
),

final as (
    select md5(concat(user_id,u.address_id)) as shipping_address_id,
    user_id,
    u.address_id,
    zipcode
    
    from users_addresses u join stg_addresses a on u.address_id = a.address_id
)

select * from final