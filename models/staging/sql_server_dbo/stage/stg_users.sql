{{
    config(
        materialized='incremental',
        unique_key=['NK_user_id','user_valid_from'],
        tags=['incremental'] 
    )
}}

with users as (
    select * from {{ ref('base_users_snapshot') }}
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
        a.NK_address_id,
        u.email,
        u.user_created_at_date_id,
        u.user_created_at_id,
        u.dbt_valid_from as user_valid_from,
        u.dbt_valid_to as user_valid_to,
        u._fivetran_synced
    
    from users u left join addresses a
        on u.NK_address_id = a.NK_address_id
)

select * from final_users

{% if is_incremental() %}

  where NK_user_id in (select NK_user_id from final_users where _fivetran_synced > (select max(_fivetran_synced) from {{ this }}))

{% endif %}
