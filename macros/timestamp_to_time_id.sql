{% macro timestamp_to_time_id(column) %}

hour({{column}})*24*60+minute({{column}})*60+second({{column}})

{% endmacro %}