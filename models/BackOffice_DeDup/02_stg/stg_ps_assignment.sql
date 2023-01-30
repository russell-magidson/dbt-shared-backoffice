{{ config(
    tags = ["ps_assignment", "backoffice"], 
    alias = 'ps_assignment'
    )
}}

SELECT
      business_unit
      , order_id
      , assignment_id
      , cust_id
      , emplid
      , start_date
      , start_time
      , assign_status
      , schedule_comment
      , weekly_hours
      , end_est_date
      , end_time
      , end_est_comment
      , end_actual_date
      , end_actual_reason
      , end_actual_comment
      , jobcode
      , reg_bill_rate
      , reg_pay_rate
      , ot_percent
      , overtime_bill_rate
      , overtime_pay_rate
      , temp_to_hire_fee
      , state
      , locality
      , locality_link
      , invoice_field_1
      , invoice_field_2
      , invoice_field_3
      , vendor_rate
      , vendor_rate_ot
      , setid
      , margin
      , return_code
      , address_seq_num
      , csf_id
      , service_area
      , markup_cd
      , pb_markup
      , jobtitle
      , rna_refill_assign
      , rna_elig_return
      , rna_refill_req
      , rna_orig_assign
      , rna_assign_ref
      , rna_req_override
      , rna_req_ov_reason
      , rna_ctrct_clnt_src
      , tax_location_cd
      , company
      , paygroup
      , rna_ncci_cd
      , oprid_entered_by
      , dttm_entered
      , hdm_id
      , rna_caf_id
      , insert_datetime as source_insert_datetime

      FROM {{ source( 'datalake-frontoffice-rgs', 'PS_ASSIGNMENT') }}

      QUALIFY ROW_NUMBER() OVER (PARTITION BY business_unit, order_id, assignment_id, cust_id, emplid ORDER BY insert_datetime DESC) = 1
