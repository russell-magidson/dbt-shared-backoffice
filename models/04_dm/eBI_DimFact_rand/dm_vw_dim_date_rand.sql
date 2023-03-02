{{ config(
    tags = ["vw_dim_date", "view"], 
    alias = "vw_dim_date", 
    materialized = 'view'
    )
}}

select *
from {{ ref( 'dm_dim_date')}}
