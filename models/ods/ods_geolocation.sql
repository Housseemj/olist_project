WITH ods_geolocation as
(
    SELECT * FROM {{source('stg','stg_geolocation')}}
)

SELECT 
    GEOLOCATION_ZIP_CODE_PREFIX, 
    GEOLOCATION_LAT, 
    GEOLOCATION_LNG, 
    upper(GEOLOCATION_CITY) as GEOLOCATION_CITY, 
    upper(GEOLOCATION_STATE) as GEOLOCATION_STATE,
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at
FROM ods_geolocation