with budget as (
    select 
        {{ dbt_utils.surrogate_key(['_row', 'product_id','month']) }} as budget_id,
        _row as NK_budget_id,
        quantity as estimated_quantity,
        month as budget_date,
        product_id as NK_product_id,
        _fivetran_synced 

    from {{ source("google_sheets", "budget") }}
)

select * from budget