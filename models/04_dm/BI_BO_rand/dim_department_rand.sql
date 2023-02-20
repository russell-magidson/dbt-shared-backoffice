{{ config(
    tags = ["dim_department", "backoffice", "rand-rusaweb"], 
    alias = "dim_department"
    )
}}

SELECT *
FROM {{ ref( 'dm_dim_department')}}
