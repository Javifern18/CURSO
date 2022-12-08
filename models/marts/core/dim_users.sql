{{
    config(
        materialized='incremental',
        unique_key=['NK_user_id','user_valid_from'],
        tags=['incremental'] 
    )
}}

with users_snapshot as (
      select * from {{ ref('stg_users') }}
),

users_addresses as (
      select * from {{ref('stg_addresses')}}
),

dim_users as (
  select 
        u.user_id,
        u.NK_user_id,
        u.first_name,
        u.last_name,
        u.phone_number,
        u.email,
        a.address,
        a.zipcode,
        a.primary_city as city,
        a.county,
        a.state,
        a.country,
        u.user_valid_from,
        u.user_valid_to

  from users_snapshot u left join users_addresses a
    on u.address_id = a.address_id
)

select * from dim_users

{% if is_incremental() %}

  where NK_user_id in (select NK_user_id from final_users where _fivetran_synced > (select max(_fivetran_synced) from {{ this }}))

{% endif %}