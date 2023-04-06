{# Log the record counts for ebi #}

{# Wait until all of the dependencies are done before generating our record counts #}
-- depends_on: {{ ref( 'dm_department_dynamic_hierarchy') }} 
-- depends_on: {{ ref( 'dm_department_search_all_levels') }} 
-- depends_on: {{ ref( 'dm_department_search') }} 
-- depends_on: {{ ref( 'dm_dim_customer') }} 
-- depends_on: {{ ref( 'dm_dim_date') }}
-- depends_on: {{ ref( 'dm_dim_department') }}
-- depends_on: {{ ref( 'dm_dim_employee') }}
-- depends_on: {{ ref( 'dm_ext_holidays') }}
-- depends_on: {{ ref( 'dm_ext_table_refresh_schedule') }}

{{ config( tags = ["recordcount"]
    ) 
}}

{{ log_record_count( 
    'eBI_DimFact'
    , "
    'dim_customer', 
    'dim_date', 
    'dim_department', 
    'dim_employee', 
    'dm_ext_holidays', 
    'dm_ext_table_refresh_schedule', 
    'dm_department_dynamic_hierarchy', 
    'dm_department_search_all_levels', 
    'dm_department_search'
    "
) }}
