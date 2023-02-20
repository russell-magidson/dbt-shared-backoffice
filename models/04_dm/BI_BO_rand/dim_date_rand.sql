{{ config(
    tags = ["dim_date", "backoffice", "rand-rusaweb"], 
    alias = "dim_date"
    )
}}

SELECT *
FROM {{ ref( 'dm_dim_date')}}
