{{ 
    config( alias = "keys_department" 
    , pre_hook = 
        "
        create table if not exists {{ var( 'keys_table_location') }}.keys_department
            as ( 
            select 'N/A' as unit, -1 dept_key, current_timestamp() as insert_datetime
            )
        " 
    )
}}

WITH maxKey AS (  
SELECT max( dept_key) + 1 AS next_key_id 

    from {{ source( 'ebi_keys', 'keys_department') }} 
) 

select distinct unit, 
    ( ( SELECT next_key_id from maxKey) + DENSE_RANK() OVER (ORDER BY unit asc) ) AS dept_key,  
    current_timestamp() AS insert_datetime 

    FROM {{ source( 'rand-rusaweb-dims', 'DIM_DEPT') }}

    where 1=1 
      and unit IS NOT NULL
      and unit NOT IN ( 
          select unit 
          from {{ source( 'ebi_keys', 'keys_department') }}  
          )
