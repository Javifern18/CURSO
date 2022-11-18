with stg_order_items as (select * from {{ source("sql_server_dbo", "order_items") }})

select *
from stg_order_items
