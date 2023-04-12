{{ config(
    tags = ["ps_rna_bh_plac_stg"], 
    alias = "ps_rna_bh_plac_stg"
    )
}}

SELECT
    rna_bh_corp_id
    ,rna_bh_plc_id
    ,seqno
    ,rna_bh_plac_action
    ,rna_stg_trans_sts
    ,rna_bh_branch_name
    ,business_unit
    ,deptid
    ,company
    ,rna_op_co
    ,order_id
    ,rna_prev_order_id
    ,assignment_id
    ,rna_bh_emplmnt_typ
    ,assign_status
    ,setid
    ,cust_id
    ,rna_customer_name
    ,customer_group
    ,bill_to_addr_num
    ,ship_to_addr_num
    ,tax_cd
    ,rna_bh_cand_id
    ,rna_bh_cand_fname
    ,rna_bh_cand_lname
    ,rna_bh_empl_type
    ,emplid
    ,rna_vi_aveid
    ,jobtitle
    ,rna_jobtitle_descr
    ,jobcode
    ,client_job_title
    ,rna_bh_cont_id
    ,rna_bh_cont_fname
    ,rna_bh_cont_lname
    ,rna_bh_plac_status
    ,rna_bh_proj_app_dt
    ,rna_bh_dhir_app_dt
    ,start_date
    ,rna_conv_start_dt
    ,rna_pnet_start_dt
    ,end_est_date
    ,end_actual_date
    ,rna_bh_term_reason
    ,end_actual_reason
    ,end_actual_comment
    ,rna_refill_assign
    ,vendor_id
    ,vms_account
    ,po_ref
    ,rna_po_effdt
    ,rna_bh_salary_unit
    ,salary
    ,rna_bh_std_fee
    ,rna_career_fee_pct
    ,career_fee
    ,rna_bh_lob
    ,rna_deptid_charged
    ,product
    ,rna_time_appr_ovrd
    ,approval_required
    ,rna_bh_plc_eval
    ,created_by
    ,datetime_created
    ,last_updated_by
    ,datetime_updated
    ,rna_exempt_status
    ,rna_offsite
    ,rna_vms_assignment
    ,order_type
    ,rna_ps_emplmnt_typ
    ,rna_admin_assgnmnt
    ,rna_fin_comments
    ,ca_po_id
    ,rna_awaitingpo_flg
    ,rna_timeentry_meth
    ,rna_pnet_ts_type
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-rg_bo', 'PS_RNA_BH_PLAC_STG')}}

QUALIFY ROW_NUMBER() OVER (PARTITION BY rna_bh_corp_id, rna_bh_plc_id ORDER BY seqno DESC) = 1
