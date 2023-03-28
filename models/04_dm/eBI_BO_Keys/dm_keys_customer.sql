{{ 
    config( alias = "keys_customer" 
    , pre_hook = 
        "
        create table if not exists {{ var( 'keys_table_location') }}.keys_customer
            as ( 
            select 'N/A' as customer_id, -1 cust_key, current_timestamp() as insert_datetime
            ) 
        "
    )
}}

WITH maxKey AS (  
SELECT max( cust_key) + 1 AS next_key_id 

    from {{ source( 'ebi_keys', 'keys_customer') }}
) 

select distinct cust_id as customer_id, 
    ( ( SELECT next_key_id from maxKey) + DENSE_RANK() OVER (ORDER BY cust_id asc) ) AS cust_key,  
    current_timestamp() AS insert_datetime 

    from {{ source( 'ebi_dedup', 'ps_customer') }}

    where 1=1 
      and cust_id IS NOT NULL
      and cust_id NOT IN ( 
          select customer_id 
          
          from {{ source( 'ebi_keys', 'keys_customer') }}
          )
