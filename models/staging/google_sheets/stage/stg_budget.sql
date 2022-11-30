with budget as (
    select * from {{ ref('base_budget') }} 
),

products as (
    select
        product_id,
        NK_product_id
    
    from {{ ref('base_products') }}
),

final_budget as (
    select
        b.NK_budget_id, 
        b.budget_id,
        b.estimated_quantity,
        b.budget_date,
        p.NK_product_id,
        p.product_id,
        b._fivetran_synced 

    from budget b left join products p
        on b.NK_product_id = p.NK_product_id   
)

select * from final_budget