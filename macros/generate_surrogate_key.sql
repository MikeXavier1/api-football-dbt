{% macro generate_surrogate_key(columns) %}
    {{ return("md5(" ~ columns | map('string') | join(" || '|' || ") ~ ")") }}
{% endmacro %}