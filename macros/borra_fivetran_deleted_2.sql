{% macro borra_fivetran_deleted_2(table,NK_column) %}

-- Selecciono los registros que voy a borrar haciendo un soft delete (registros con igual NK_id y en uno de ellos el campo _fivetran_deleted = true)
quiero_borrar as (
    select {{NK_column}} as NK from {{table}}
        where _fivetran_deleted = TRUE
)

-- Hacemos un left join de toda mi tabla a la que le quiero hacer el borrado con las NK que he seleccionado en quiero_borrar
-- De esta manera me quedará mi tabla original y una columna más con todo nulos menos las NK repetidas en los registros que quiero borrar
-- Selecciono toda mi tabla donde el campo NK que he creado yo es nulo y descarto así los que quiero borrar
,me_quedo_con as (
    select * from {{table}} a left join quiero_borrar b 
        on a.{{NK_column}}=b.NK
        
        where b.NK is null
)

-- Me quedo con mi tabla original menos el campo NK que he creado y el campo _fivetran_deleted que ya no necesito y además debe ser = false
select * exclude(NK,_fivetran_deleted) from me_quedo_con

{% endmacro %}