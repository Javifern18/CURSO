{% macro borra_fivetran_deleted_1(table,NK_column) %}

fivetran_not_deleted as (
    select * from {{table}} where {{NK_column}} not in (select {{NK_column}} from {{table}} where _fivetran_deleted=true)
)

select * exclude (_fivetran_deleted) from fivetran_not_deleted

{% endmacro %}