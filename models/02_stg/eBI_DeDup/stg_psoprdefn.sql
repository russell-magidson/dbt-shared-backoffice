{{ config(
    tags = ["psoprdefn"], 
    alias = "psoprdefn"
    )
}}

SELECT 
    oprid
    ,version
    ,oprdefndesc
    ,emplid
    ,emailid
    ,oprclass
    ,rowsecclass
    ,operpswd
    ,ptoperpswdv2
    ,operpswdsalt
    ,encrypted
    ,symbolicid
    ,language_cd
    ,multilang
    ,currency_cd
    ,lastpswdchange
    ,acctlock
    ,prcsprflcls
    ,defaultnavhp
    ,failedlogins
    ,expent
    ,oprtype
    ,useridalias
    ,lastsignondttm
    ,lastupddttm
    ,lastupdoprid
    ,ptallowswitchuser
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PSOPRDEFN')}}

QUALIFY ROW_NUMBER() OVER (PARTITION BY oprid ORDER BY lastupddttm DESC) = 1
