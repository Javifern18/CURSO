with users as (
    select 
        {{ dbt_utils.surrogate_key(['user_id', 'updated_at']) }} as user_id,
        user_id as NK_user_id,
        first_name,
        last_name,
        replace(phone_number,'-','')::number as phone_number,
        address_id as NK_address_id,
        email,
        created_at as user_created_at,
        updated_at as user_updated_at,
        _fivetran_deleted,
        _fivetran_synced

    from {{ source("sql_server_dbo", "users") }}
),

fivetran_not_deleted as (
    select
        user_id,
        NK_user_id,
        first_name,
        last_name,
        phone_number,
        NK_address_id,
        email,
        user_created_at,
        user_updated_at,
        _fivetran_synced
    
    from users where NK_user_id not in (select NK_user_id from users where _fivetran_deleted=true)
)

select * from fivetran_not_deleted