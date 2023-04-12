{{ config(
    tags = ["dim_customer"], 
    alias = "dim_customer"
    )
}}

select *
from {{ ref( 'dm_dim_customer')}}
