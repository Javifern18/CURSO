with stg_budget as (select * from {{ source("google_sheets", "budget") }})

select *
from stg_budget