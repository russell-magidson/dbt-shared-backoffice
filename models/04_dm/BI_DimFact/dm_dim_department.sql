{{ config(
    tags = ["dim_department", "po_assignments"], 
    alias = "dim_department"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_dim_department")}}

UNION ALL

SELECT -1, 'N/A', 'N/A', NULL, 'N/A', 'N/A', 'N/A', 'N/A', NULL, 'N/A', 'N/A', 'N/A'
    , 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A'
    , 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', NULL, 'N/A', 'N/A'
    , 'N/A', 'N/A', NULL, NULL, 'N/A', 'N/A', 'N/A'
    , -1 as dept_key, -1 as department_key
    , current_timestamp() as insert_datetime
