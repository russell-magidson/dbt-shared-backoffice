{{ config(
    tags = ["ps_ca_contr_hdr"], 
    alias = 'ps_ca_contr_hdr'
    )
}}

SELECT
    contract_num
    ,addr_seq_num_bill
    ,allocation_done
    ,addr_seq_num_sold
    ,business_unit
    ,business_unit_bi
    ,bill_type_id
    ,bill_to_cust_id
    ,contr_legal_entity
    ,contr_net_amt
    ,contr_template_flg
    ,subcust_qual1
    ,subcust_qual2
    ,cntct_seq_sold
    ,cntct_seq_bill
    ,contr_mstr_flg
    ,contract_sign_dt
    ,ca_status
    ,ca_proc_status
    ,contract_type
    ,credit_check
    ,revised_gross
    ,revised_net
    ,revised_reduct
    ,currency_cd
    ,end_dt
    ,legal_review_flg
    ,lastupddttm
    ,lastupdoprid
    ,mast_contr_id
    ,pymnt_terms_cd
    ,proposal_id
    ,po_ref
    ,descr
    ,parent_contr_id
    ,region_cd
    ,start_dt
    ,sold_to_cust_id
    ,ship_to_cust_id
    ,tot_contr_amt
    ,dfr_rev_acct_dt
    ,rt_type
    ,cotermination
    ,last_bill_plan_nbr
    ,last_acct_plan_nbr
    ,percentage
    ,total_reductions
    ,amendment_dt
    ,chg_id
    ,chg_cmp_dt
    ,gm_cs_dtl_flag
    ,gm_sal_dtl_flag
    ,gm_method_payment
    ,loc_reference_id
    ,contract_admin
    ,ca_reimb_agree
    ,ca_rqst_src
    ,payment_method
    ,pvn_gen_lvl
    ,region_code
    ,separate_bil_rev_f
    ,separate_bil_rev
    ,revised_gross_rev
    ,revised_reduct_rev
    ,contract_role
    ,contract_total_bil
    ,contract_total_rev
    ,allocation_rev
    ,revised_net_rev
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_CA_CONTR_HDR')}}
    
WHERE business_unit IN ('RTSBU', 'CLCBU')

QUALIFY ROW_NUMBER() OVER (PARTITION BY  contract_num ORDER BY lastupddttm DESC) = 1
