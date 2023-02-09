{{ config(
    tags = ["dim_date", "backoffice"], 
    alias = "dim_date"
    )
}}

SELECT *
FROM {{ ref( 'dm_dim_date')}}
