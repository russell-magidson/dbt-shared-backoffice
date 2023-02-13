{{ 
    config( 
        alias = "keys_employee" 
    )
}}

WITH maxKey AS (  
SELECT max( employee_key) + 1 AS next_key_id 

    from {{ source( 'bi_bo_keys', 'keys_employee') }} 
) 

select distinct emplid as employee_id, 
    ( ( SELECT next_key_id from maxKey) + DENSE_RANK() OVER (ORDER BY emplid asc) ) AS employee_key,  
    current_timestamp() AS insert_datetime 

    from {{ source( 'bi_dedup', 'ps_job') }}

    where 1=1 
    and emplid IS NOT NULL
    and emplid NOT IN ( 
        select employee_id 

        from {{ source( 'bi_bo_keys', 'keys_employee') }} 
            )
