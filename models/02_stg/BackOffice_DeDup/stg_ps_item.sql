{{ config(
    tags = ["ps_item", "dedup", "backoffice"], 
    alias = "ps_item"
    )
}}

SELECT
        business_unit
        ,cust_id
        ,TRIM(item) AS item
        ,item_line
        ,item_status
        ,entry_type
        ,entry_reason
        ,entry_event
        ,ref_reason
        ,bal_amt
        ,accounting_dt
        ,asof_dt
        ,post_dt
        ,due_dt
        ,cr_analyst
        ,sales_person
        ,collector
        ,dispute_status
        ,dispute_dt
        ,dispute_amount
        ,po_ref
        ,po_line
        ,document
        ,document_line
        ,psitem.pymnt_terms_cd
        ,terms_desc.description AS payment_term_description
        ,disc_amt
        ,disc_amt1
        ,disc_dt
        ,disc_dt1
        ,disc_level
        ,disc_days
        ,due_days
        ,allow_disc
        ,aging_category
        ,dst_id_ar
        ,hist_status
        ,dun_dt
        ,dun_seq_num
        ,st_dt
        ,fc_dt
        ,fc_amt
        ,oc_admin_dt
        ,oc_admin_amt
        ,oc_pnlty_dt
        ,oc_pnlty_amt
        ,overdue_chg_line
        ,item_line_orig
        ,update_status
        ,collection_status
        ,collection_dt
        ,item_seq_num
        ,bill_of_lading
        ,subcust_qual1
        ,subcust_qual2
        ,subcust_status
        ,bal_currency
        ,rt_type
        ,rate_mult
        ,rate_div
        ,bal_amt_base
        ,bal_amt_last
        ,currency_cd
        ,entry_use_id
        ,vat_dclrtn_point
        ,vat_recalc_flg
        ,country_vat_billfr
        ,country_vat_billto
        ,country_ship_to
        ,country_ship_from
        ,vat_calc_gross_net
        ,vat_entity
        ,vat_excptn_type
        ,vat_excptn_certif
        ,vat_rgstrn_buyer
        ,vat_round_rule
        ,order_no
        ,contract_num
        ,business_unit_bi
        ,business_unit_om
        ,address_seq_num
        ,letter_cd
        ,tran_from_bu
        ,tran_from_custid
        ,consol_bus_unit
        ,consol_invoice
        ,payment_method
        ,draft_bu
        ,draft_id
        ,draft_approval
        ,draft_doc
        ,draft_currency
        ,draft_format
        ,draft_status
        ,bank_setid
        ,bank_cd
        ,bank_acct_key
        ,dd_bu
        ,dd_id
        ,dd_currency
        ,dd_status
        ,dd_profile_id
        ,draft_type
        ,process_instance
        ,user_amt1
        ,user_amt2
        ,user_amt3
        ,user_amt4
        ,user_amt5
        ,user_amt6
        ,user_amt7
        ,user_amt8
        ,user_dt1
        ,user_dt2
        ,user_dt3
        ,user_dt4
        ,user1
        ,user2
        ,user3
        ,user4
        ,user5
        ,user6
        ,user7
        ,user8
        ,user9
        ,user10
        ,orig_item_amt
        ,last_activity_dt
        ,st_id_num
        ,doubtful
        ,draft_busn_event
        ,draft_sub_event
        ,sales_person2
        ,region_cd
        ,revalue_flag
        ,packslip_no
        ,sbi_num
        ,lc_id
        ,netting_sw
        ,net_ref_id
        ,receivable_type
        ,entity_code
        ,pprc_promo_cd
        ,claim_no
        ,claim_setid
        ,ar_specialist
        ,broker_id
        ,carrier_id
        ,claim_dt
        ,class_of_trade
        ,deduction_status
        ,deduction_dt
        ,division
        ,dt_invoiced
        ,inv_prod_fam_cd
        ,invoice
        ,invoice_bu
        ,major_class
        ,memo_status_cd
        ,merch_type
        ,proof_of_delivery
        ,ship_from_bu
        ,ship_to_addr_num
        ,ship_to_cust_id
        ,sold_to_addr_num
        ,sold_to_cust_id
        ,vat_treatment_grp
        ,physical_nature
        ,country_loc_buyer
        ,state_loc_buyer
        ,country_loc_seller
        ,state_loc_seller
        ,vat_svc_supply_flg
        ,vat_service_type
        ,country_vat_perfrm
        ,state_vat_perfrm
        ,country_vat_supply
        ,state_vat_supply
        ,state_ship_from
        ,state_ship_to
        ,vat_rpt_cntry_src
        ,state_vat_default
        ,convers_exists
        ,ag_ref_nbr
        ,invoice_dt
        ,ar_ebp_paym_dt
        ,ar_ebp_proc_by
        ,business_unit_ca
        ,contract_line_num
        ,subrog_case_num
        ,sp_id
        ,in_use_flag
        ,entered_dttm
        ,oprid
        ,last_update_dttm
        ,oprid_last_updt
        ,ar_inbound_ipac
        ,psitem.insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_ITEM' )}} AS psitem

LEFT JOIN (SELECT *
            FROM {{ source( 'rand-rusaweb-dedup', 'ps_rna_pymnt_term')}} 
            QUALIFY ROW_NUMBER() OVER (PARTITION BY pymnt_terms_cd ORDER BY pymnt_terms_cd DESC) = 1) AS terms_desc
    ON psitem.pymnt_terms_cd = terms_desc.pymnt_terms_cd

QUALIFY ROW_NUMBER() OVER (PARTITION BY business_unit, cust_id, item, item_line ORDER BY last_update_dttm DESC) = 1
