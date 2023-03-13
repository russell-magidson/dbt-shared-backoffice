{{ config(
    tags = ["ps_rs_assignment"], 
    alias = "ps_rs_assignment"
    )
}}

SELECT
    assignment_id
    ,emplid
    ,system_source
    ,business_unit
    ,so_id
    ,so_line
    ,project_id
    ,cust_id
    ,replaced_asgn_id
    ,activity_id
    ,contract_line_num
    ,assignment_id2
    ,entered_by
    ,dttm_entered
    ,lastupdoprid
    ,lastupddttm
    ,end_actual_date
    ,end_actual_reason
    ,end_actual_comment
    ,empl_rcd_num
    ,name
    ,fee_schedule
    ,schedule_comment
    ,fee_schedule_sent
    ,fee_schedule_sign
    ,guarantee_days
    ,salary
    ,compensation
    ,actual_fee
    ,income
    ,deptid_rev
    ,fo_fall_off
    ,fall_off_cd
    ,days_worked
    ,fall_off_amt
    ,bill_date
    ,vendor_id
    ,vndr_loc
    ,tth_conv_tmp
    ,tth_conv_car
    ,company
    ,business_unit_hr
    ,deptid
    ,jobcode
    ,paygroup
    ,gp_paygroup
    ,taskgroup
    ,workgroup
    ,tax_location_cd
    ,location
    ,assign_job_option
    ,po_ref
    ,awaiting_po_flg
    ,pre_approval_flg
    ,ca_alloc_method
    ,msg_pending
    ,contract_num
    ,ship_from_loc
    ,tax_exempt_flag
    ,tax_exempt_cert
    ,tax_cd
    ,tax_group
    ,tax_trans_type
    ,tax_trans_sub_type
    ,physical_nature
    ,product_id
    ,manager_contact_id
    ,invoice
    ,candidate_type
    ,asset_id
    ,rsrc_type
    ,res_ln_nbr
    ,requirement_id
    ,proj_role
    ,address_seq_num
    ,task_type
    ,descr
    ,assigned_to
    ,reserved_flag
    ,descr254_mixed
    ,descr254
    ,cntct_seq_num
    ,status_appr_once
    ,status_appr_second
    ,datechg_appr_once
    ,dtchg_appr_second
    ,business_unit_am
    ,shop_id
    ,craft_id
    ,business_unit_wo
    ,wo_id
    ,wo_task_id
    ,res_calendar
    ,replaced_by
    ,original_asgn_id
    ,replacement_sts
    ,replac_request_dt
    ,replac_start_dt
    ,time_start
    ,skip_inelgbl_days
    ,processed_cd
    ,process_instance
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_RS_ASSIGNMENT')}}

WHERE end_actual_date is null OR EXTRACT(YEAR FROM end_actual_date) > 2020

QUALIFY ROW_NUMBER() OVER (PARTITION BY assignment_id ORDER BY lastupddttm DESC) = 1
