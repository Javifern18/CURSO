{{
    config(
        materialized='incremental',
        tags=['incremental'] 
    )
}}

with events_info as (
    select * from {{ ref('fct_events') }} 
),
users_info as (
    select * from {{ref('dim_users')}}
),

events_by_user_session as (
    select
        e.session_id,
        e.event_date_id,
        e.event_created_at_id,
        u.user_id,
        e.product_id,
        e._fivetran_synced,
        {{column_values_to_metrics(ref('fct_events'), 'event_type')}}

    from events_info e join users_info u 
        on e.user_id = u.user_id
    {{dbt_utils.group_by(6)}}
)

select * from events_by_user_session

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}
