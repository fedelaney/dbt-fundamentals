{% macro union_relations_by_prefix(database, schema, prefix) %}

    {% set table = dbt_utils.get_relations_by_prefix(database=database, schema=schema, prefix=prefix) %}

    {% for t in tables %}
        select * from {{t.database}}.{{t.schema}}.{{t.name}}  
        {% if not loop.last %}
            union all
        {% endif %} 
    {% endfor %}

{% endmacro %}