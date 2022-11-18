with stg_users as (select * from {{ source("sql_server_dbo", "users") }})

select *
from stg_users
