{{ config(
    tags = ["dim_employee"], 
    alias = "dim_employee"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_dim_employee")}}

UNION ALL

SELECT 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A'
    ,'N/A', 'N/A', 'N/A', 'N/A', 'N/A', NULL, 'N/A'
    ,'N/A', NULL, NULL, NULL, NULL, NULL
    ,NULL, NULL, 'N/A', 'N/A', 'N/A', 'N/A', -1
    ,current_timestamp() as insert_datetime
