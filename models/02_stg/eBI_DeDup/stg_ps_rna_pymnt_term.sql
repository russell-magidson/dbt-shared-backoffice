{{ config(
    tags = ["ps_rna_pymnt_term"], 
    alias = "ps_rna_pymnt_term"
    )
}}

SELECT DISTINCT crconf.select_value as pymnt_terms_cd
                ,crconf.descr AS description

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_PAY_TRMS_TBL' )}} as pterms

INNER JOIN {{ source( 'datalake-frontoffice-rg_bo', 'PS_RNA_CR_CONFG')}} as crconf
        ON pterms.pymnt_terms_cd = crconf.select_value

WHERE (pterms.ps_system = 'AR' AND crconf.fieldname = 'PYMNT_TERMS_CD' AND crconf.rna_solutions = 'N')
    OR crconf.select_value = 'OTHR'
