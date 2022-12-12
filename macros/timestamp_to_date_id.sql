{% macro timestamp_to_date_id(column) %}

year(to_date({{column}}))*10000+month(to_date({{column}}))*100+day(to_date({{column}}))

{% endmacro %}