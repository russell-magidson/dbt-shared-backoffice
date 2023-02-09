{{ config(
    tags = ["dim_customer", "backoffice"], 
    alias = "dim_customer"
    )
}}

SELECT *
FROM {{ ref( 'dm_dim_customer')}}
