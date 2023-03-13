{{ config(
    tags = ["dim_employee"], 
    alias = "dim_employee"
    )
}}

select *
from {{ ref( 'dwh_dim_employee')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_employee')}}
                        )

UNION ALL

SELECT 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A'
    ,'N/A', 'N/A', 'N/A', 'N/A', 'N/A', NULL, 'N/A'
    ,'N/A', NULL, NULL, NULL, NULL, NULL
    ,NULL, NULL, 'N/A', 'N/A', 'N/A', 'N/A', -1
    ,(SELECT max(insert_datetime) 
        from {{ ref( 'dwh_dim_employee')}}
      ) as insert_datetime
