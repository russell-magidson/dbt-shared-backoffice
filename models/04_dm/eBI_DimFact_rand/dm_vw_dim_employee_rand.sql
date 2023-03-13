{{ config(
    tags = ["vw_dim_employee", "view"], 
    alias = "vw_dim_employee", 
    materialized = 'view'
    )
}}

select *
from {{ ref( 'dm_dim_employee')}}
