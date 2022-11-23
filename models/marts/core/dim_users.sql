with stg_users as (
    select * from {{ ref('stg_users') }}
),

stg_addresses as (
    select * from {{ ref('stg_addresses') }}
),

final as (
    select * from stg_users u join stg_addresses a
        on u.address_id = a.address_id
)

select * from final