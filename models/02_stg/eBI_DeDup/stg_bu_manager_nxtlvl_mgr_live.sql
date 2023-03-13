{{ config(
    tags = ["bu_manager_nxtlvl_mgr_live"], 
    alias = 'bu_manager_nxtlvl_mgr_live'
    )
}}

SELECT 
        name ,nameprefix, namesuffix, lastname, firstname, middlename, preffirstname
        , address1, address2, country, city, state, postal, jobcode, jobtitle, emplstatus, workphone
        , supervisorid, mgrname, mgrnameprefix, mgrnamesuffix, mgrlastname, mgrfirstname, mgrmiddlename, mgrpreffirstname
        , mgraddress1, mgraddress2, mgrcountry, mgrcity, mgrstate, mgrpostal, mgrjobcode, mgrjobtitle, mgremplstatus
        , mgrworkphone, mgrsupervisorid, segment_group, branch, emplid, effdt, hiredt, rehiredt, deptid
        , mgremplid, mgreffdt, mgrhiredt, mgrrehiredt, mgrdeptid

FROM {{ source( 'rand-rusaweb-maps', 'BU_MANAGER_NXTLVL_MGR_LIVE')}} 

QUALIFY ROW_NUMBER() OVER (PARTITION BY name, branch) = 1
