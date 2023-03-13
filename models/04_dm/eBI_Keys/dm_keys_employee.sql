{{ 
    config( alias = "keys_employee" 
    , pre_hook = 
        "
        create table if not exists {{ var( 'keys_table_location') }}.keys_employee
            as (
            select 'N/A' as employee_id, -1 employee_key, current_timestamp() as insert_datetime
            ) 
        "
    )   
}}

WITH maxKey AS (  
SELECT max( employee_key) + 1 AS next_key_id 

    from {{ source( 'ebi_keys', 'keys_employee') }} 
) 

select distinct emplid as employee_id, 
    ( ( SELECT next_key_id from maxKey) + DENSE_RANK() OVER (ORDER BY emplid asc) ) AS employee_key,  
    current_timestamp() AS insert_datetime 

    from {{ source( 'ebi_dedup', 'ps_job') }}

    where 1=1 
    and emplid IS NOT NULL
    and emplid NOT IN ( 
        select employee_id 

        from {{ source( 'ebi_keys', 'keys_employee') }} 
            )
