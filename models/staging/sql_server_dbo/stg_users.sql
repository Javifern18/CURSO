with users as (
    select * from {{ ref('base_users') }}
),

addresses as (
    select
        address_id,
        NK_address_id 
    
    from {{ ref('base_addresses') }}
),

final_users as (
    select
        u.user_id,
        u.NK_user_id,
        u.first_name,
        u.last_name,
        replace(u.phone_number,'-','')::number as phone_number,
        a.address_id,
        u.email,
        u.user_created_at,
        u.user_updated_at,
        u._fivetran_deleted,
        u._fivetran_synced
    
    from users u left join addresses a
        on u.NK_address_id = a.NK_address_id
)

select * from final_users
