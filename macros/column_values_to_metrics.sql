{% macro column_values_to_metrics(table, column) %}

  {% set query_sql %}
    SELECT DISTINCT {{column}} FROM {{table}}
    {% endset %}

    {% if execute %}
        {% set column_values = run_query(query_sql).columns[0].values() %}
    
        {% for column_value in column_values %}
            sum(case when {{column}}='{{column_value}}' then 1 else 0 end) as {{column_value}}
            {% if not loop.last %},{% endif %}
        {% endfor %}
    {% else %}

    {% endif %}

{% endmacro %}