{{ config(
    tags = ["ps_item_activity", "dedup", "backoffice"], 
    alias = 'ps_item_activity'
    )
}}

SELECT
        psia.business_unit
        , psia.cust_id
        , TRIM(psia.item) AS item
        , psia.item_line
        , psia.item_seq_num
        , psia.entry_type
        , psia.entry_reason
        , psia.entry_amt
        , psia.entry_event
        , psia.accounting_dt
        , psia.post_dt
        , psia.asof_dt
        , psia.document
        , psia.document_line
        , psia.deposit_bu
        , psia.deposit_id
        , psia.payment_seq_num
        , psia.draft_bu
        , psia.draft_id
        , psia.group_bu
        , psia.group_id
        , psia.group_seq_num
        , psia.hist_status
        , psia.subcust_qual1
        , psia.subcust_qual2
        , psia.subcust_status
        , psia.entry_currency
        , psia.rt_type
        , psia.rate_mult
        , psia.rate_div
        , psia.payment_amt
        , psia.payment_currency
        , psia.pymt_rt_type
        , psia.pymt_rate_mult
        , psia.pymt_rate_div
        , psia.entry_amt_base
        , psia.currency_cd
        , psia.real_gain_loss
        , psia.entry_use_id
        , psia.origin_id
        , psia.payment_id
        , psia.group_type
        , psia.voucher_id
        , psia.sent_to_ap
        , psia.consol_bus_unit
        , psia.consol_invoice
        , psia.cr_analyst
        , psia.sales_person
        , psia.collector
        , psia.po_ref
        , psia.po_line
        , psia.bill_of_lading
        , psia.order_no
        , psia.contract_num
        , psia.business_unit_bi
        , psia.business_unit_om
        , psia.bank_setid
        , psia.bank_cd
        , psia.bank_acct_key
        , psia.dd_bu
        , psia.dd_id
        , psia.posted_pi
        , psia.arre_status
        , psia.process_instance
        , psia.user_amt1
        , psia.user_amt2
        , psia.user_amt3
        , psia.user_amt4
        , psia.user_amt5
        , psia.user_amt6
        , psia.user_amt7
        , psia.user_amt8
        , psia.user_dt1
        , psia.user_dt2
        , psia.user_dt3
        , psia.user_dt4
        , psia.user1
        , psia.user2
        , psia.user3
        , psia.user4
        , psia.user5
        , psia.user6
        , psia.user7
        , psia.user8
        , psia.user9
        , psia.user10
        , psia.st_id_num
        , psia.vat_advpay_flg
        , psia.unpost_reason
        , psia.pc_distrib_status
        , psia.ws_reason
        , psia.sub_group_id
        , psia.sent_to_purchasing
        , psia.business_unit_ca
        , psia.contract_line_num
        , psia.subrog_case_num
        , psia.remit_addr_seq_num
        , psia.insert_datetime as source_insert_datetime

FROM {{ source( 'rand-rusaweb-dedup', 'ps_item' ) }} as psi

INNER JOIN {{ source( 'datalake-frontoffice-fs_bo', 'PS_ITEM_ACTIVITY' ) }} as psia
    ON psi.BUSINESS_UNIT = psia.BUSINESS_UNIT
    AND psi.ITEM = TRIM(psia.ITEM)
    AND psi.CUST_ID = psia.CUST_ID
    AND psi.ITEM_LINE = psia.ITEM_LINE

WHERE EXTRACT(YEAR FROM psia.post_dt) >= 2021

QUALIFY ROW_NUMBER() OVER (PARTITION BY  psia.business_unit, psia.cust_id, psia.item, psia.item_line, psia.item_seq_num ORDER BY psia.accounting_dt DESC) = 1
