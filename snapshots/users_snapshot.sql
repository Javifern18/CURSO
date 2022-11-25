{% snapshot users_snapshot %}

{{
    config(
      unique_key='NK_user_id',
      strategy='timestamp',
      updated_at='user_updated_at',
    )
}}

select * from {{ ref('stg_users') }}

{% endsnapshot %}