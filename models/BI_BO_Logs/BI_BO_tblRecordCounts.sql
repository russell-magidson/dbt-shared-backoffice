{# Log the record counts for BI_BO #}
{{ log_record_counts( 
    'BI_BO'
    , "
    'dim_customer', 
    'dim_date', 
    'dim_department', 
    'dim_employee', 
    'ext_table_refresh_schedule'
    "
) }}
