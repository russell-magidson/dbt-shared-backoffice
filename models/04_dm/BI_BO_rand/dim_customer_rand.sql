{{ config(
    tags = ["dim_customer", "backoffice", "rand-rusaweb"], 
    alias = "dim_customer"
    )
}}

SELECT *
FROM {{ ref( 'dm_dim_customer')}}
