{%- macro filter_by_date(delta_in_days) -%}

  {% if is_incremental() %}

    {% if var("end_date") == "null" %}
      {% set end_date = "CURRENT_DATE()" %}
    {% else %}
      {% set end_date = "DATE('" + var("end_date") + "')" %}
    {% endif %}

WHERE DATE(idate) between DATE_SUB({{ end_date }}, INTERVAL {{ delta_in_days }} DAY) and {{ end_date }}
    or DATE(udate) between DATE_SUB({{ end_date }}, INTERVAL {{ delta_in_days }} DAY) and {{ end_date }}
    
  {% endif %}

{%- endmacro -%}
