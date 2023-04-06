{{ config(
    tags = ["dim_customer"], 
    alias = "dim_customer"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_dim_customer")}}

UNION ALL

SELECT 'N/A' as setid
    , 'N/A' as customer_id
    , 'N/A' as customer_name
    , 'N/A' as corporate_customer_name
    , 'N/A' as customer_short_name
    , 'N/A' as original_customer_name
    , 'N/A' as original_corporate_customer_name
    , 'N/A' as customer_status
    , 'N/A' as customer_status_description
    , NULL as add_dt
    , 'N/A' as last_maint_oprid
    , NULL as date_last_maint
    , 'N/A' as corporate_setid
    , 'N/A' as customer_type
    , 'N/A' as rna_source_system
    , 'N/A' as department_id
    , NULL as customer_since_dt
    , 'N/A' as corporate_customer_id
    , 'N/A' as rna_billing_method
    , 'N/A' as rna_billing_method_description
    , 'N/A' as is_vms_customer
    , 'N/A' as rna_time_entry_method
    , 'N/A' as rna_time_entry_method_description
    , 'N/A' as po_customer
    , 'N/A' as rna_tracking_funds
    , 'N/A' as po_tracking_method
    , 'N/A' as analyst_code
    , 'N/A' as analyst_name
    , 'N/A' as analyst_manager
    , 'N/A' as account_type
    , 'N/A' as vms_source_code
    , 'N/A' as automated_vms
    , 'N/A' as bill_cycle_id
    , 'N/A' as require_po
    , 'N/A' as pymnt_terms_cd
    , 'N/A' as payment_term_description
    , 'N/A' as risk_code
    , 'N/A' as risk_code_description
    , 'N/A' as credit_class
    , 'N/A' as credit_class_description
    , NULL as credit_limit
    , NULL as last_customer_payment
    , 'N/A' as customer_we
    , 'N/A' as rna_vms_sep_pay_bi
    , 'N/A' as do_not_use_flag
    , -1 as cust_key
    , (SELECT max(insert_datetime) 
        FROM {{ ref( 'dwh_dim_customer')}}
        ) as insert_datetime
