{{ config(
    tags = ["ps_cust_address"], 
    alias = 'ps_cust_address'
    )
}}

SELECT 
    SETID, CUST_ID,  cast( ADDRESS_SEQ_NUM as integer) as ADDRESS_SEQ_NUM, EFFDT, EFF_STATUS, ALT_NAME1, ALT_NAME2, LANGUAGE_CD, TAX_CD
    , COUNTRY, ADDRESS1, ADDRESS2, ADDRESS3, ADDRESS4, CITY, NUM1, NUM2, HOUSE_TYPE
    , ADDR_FIELD1, ADDR_FIELD2, ADDR_FIELD3, COUNTY, STATE, POSTAL, GEO_CODE, IN_CITY_LIMIT, COUNTRY_CODE, PHONE, EXTENSION, FAX
    , LAST_EXP_CHK_DTTM, LAST_MAINT_OPRID, DATE_LAST_MAINT, URL_LONG, TAX_LOCATION_CD, INSERT_DATETIME as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-rgs', 'PS_CUST_ADDRESS')}} 

QUALIFY ROW_NUMBER() OVER (PARTITION BY setid, cust_id ORDER BY cast( ADDRESS_SEQ_NUM as integer) DESC, EFFDT DESC, DATE_LAST_MAINT desc) = 1
