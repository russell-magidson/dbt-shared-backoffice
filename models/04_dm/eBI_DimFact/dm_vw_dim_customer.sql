{{ config(
    tags = ["vw_dim_customer", "view"], 
    alias = "vw_dim_customer", 
    materialized = 'view'
    )
}}

select *
from {{ ref( 'dm_dim_customer')}}
