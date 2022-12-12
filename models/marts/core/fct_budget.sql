{{
    config(
        materialized='incremental',
        unique_key=['NK_budget_id'],
        tags=['incremental'] 
    )
}}

with budget_info as (
    select
        budget_id,
        NK_budget_id,
        year(budget_date)*100+month(budget_date) as date_month_id,
        product_id,
        estimated_quantity,
        _fivetran_synced    

    from {{ ref('stg_budget') }}
),

product_info as (
    select
        NK_product_id, 
        product_id,
        product_price
    
    from {{ ref('dim_products') }}
),

final_budget as (
    select
        b.budget_id,
        b.NK_budget_id,
        b.date_month_id,
        p.NK_product_id, 
        b.product_id,
        b.estimated_quantity,
        b.estimated_quantity*p.product_price as estimated_profit,
        b._fivetran_synced
    
    from budget_info b join product_info p
        on b.product_id = p.product_id
)

select * from final_budget

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}