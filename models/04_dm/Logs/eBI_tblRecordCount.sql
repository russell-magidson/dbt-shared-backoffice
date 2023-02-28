{# Log the record counts for ebi #}

{# Wait until all of the dependencies are done before generating our record counts #}
{# -- depends_on: {{ ref('dm_ps_assignment') }} #}
 
{{ config( tags = ["recordcount"]
    , enabled = false 
    ) 
}}

{{ log_record_count( 
    'eBI'
    , "
    'dim_customer', 
    'dim_date', 
    'dim_department', 
    'dim_employee', 
    'ext_table_refresh_schedule'
    "
) }}
