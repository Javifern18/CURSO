{% snapshot base_users_snapshot %}

{{
    config(
      unique_key='NK_user_id',
      strategy='timestamp',
      updated_at='user_updated_at',
      invalidate_hard_deletes=True,
      tags=['SILVER','Bases','Snapshot'],
    )
}}


with users as (
    select 
        {{ dbt_utils.surrogate_key(['user_id', 'updated_at']) }} as user_id,
        user_id as NK_user_id,
        first_name,
        last_name,
        replace(phone_number,'-','')::number as phone_number,
        address_id as NK_address_id,
        email,
        year(to_date(created_at))*10000+month(to_date(created_at))*100+day(to_date(created_at)) as user_created_at_date_id,
        to_date(created_at) as user_created_at_date,
        to_time(created_at) as user_created_at,
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
        user_created_at_date_id,
        user_created_at_date,
        user_created_at,
        user_updated_at,
        _fivetran_synced
    
    from users where NK_user_id not in (select NK_user_id from users where _fivetran_deleted=true)
)

select * from fivetran_not_deleted

{% endsnapshot %}