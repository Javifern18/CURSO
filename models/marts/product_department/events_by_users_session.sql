with events_info as (
    select * from {{ ref('fct_events') }} 
),
users_info as (
    select * from {{ref('dim_users')}}
),

events_by_user_session as (
    select
 --       {{ dbt_utils.surrogate_key(['e.session_id','u.user_id','e.event_created_at']) }} as events_by_user_session_id,   ?????
        e.session_id,
        e.date_id,
        e.event_created_at,
        u.user_id,
        e.product_id,
        {{column_values_to_metrics(ref('fct_events'), 'event_type')}}

    from events_info e join users_info u 
        on e.user_id = u.user_id
    {{dbt_utils.group_by(5)}}
--    {{dbt_utils.group_by(6)}}   || Si se añade bien la surrogate key no tendria sentido el group by
)

select * from events_by_user_session
