with stg_events as (
    select * from {{ ref('stg_events') }} 
),
stg_users as (
    select * from {{ref('stg_users')}}
),

int_session_events_users as (
    select e.session_id,
    e.event_created_at,
    u.user_id,
    e.product_id,
    {{column_values_to_metrics(ref('stg_events'), 'event_type')}}

    from stg_events e join stg_users u 
        on e.user_id = u.user_id
    {{dbt_utils.group_by(4)}}
)

select * from int_session_events_users

