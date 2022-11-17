with stg_events as (select * from {{ source("sql_server_dbo", "events") }})

select *
from stg_events