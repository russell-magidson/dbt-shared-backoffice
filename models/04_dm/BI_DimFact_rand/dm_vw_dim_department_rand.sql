{{ config(
    tags = ["vw_dim_department", "view"], 
    alias = "vw_dim_department", 
    materialized = 'view'
    )
}}

select *
from {{ ref( 'dm_dim_department')}}
