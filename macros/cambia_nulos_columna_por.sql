{% macro cambia_nulos_columna_por(column, cambio) %}

    case 
        when {{column}} is null then '{{cambio}}' 
        else {{column}}
    end

{% endmacro %}

-- OJO el valor de salida es un varchar