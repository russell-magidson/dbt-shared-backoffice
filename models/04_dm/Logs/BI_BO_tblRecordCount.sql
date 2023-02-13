{# Log the record counts for BI_BO #}

{# Wait until all of the dependencies are done before generating our record counts #}
{# -- depends_on: {{ ref('dm_ps_assignment') }} #}
 
{{ config( tags = ["recordcount"] ) }}

{{ log_record_count( 
    'BI_BO'
    , "
    'dim_customer', 
    'dim_date', 
    'dim_department', 
    'dim_employee', 
    'ext_table_refresh_schedule'
    "
) }}
