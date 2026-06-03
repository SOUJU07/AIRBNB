{{
  config(
    materialized = 'incremental',
    unique_key='HOST_ID'
    )
}}


SELECT 
    HOST_ID,
    REPLACE(HOST_NAME, ' ', '_') as HOST_NAME,
    HOST_SINCE as HOST_SINCE,
    IS_SUPERHOST,
    CASE
        WHEN RESPONSE_RATE > 95 THEN 'Very Good'
        WHEN RESPONSE_RATE >80 AND RESPONSE_RATE <=95 THEN 'Good'
        WHEN RESPONSE_RATE >60 AND RESPONSE_RATE <=80 THEN 'Fair'
        ELSE 'Poor'
    END AS RESPONSE_RATE,
    CREATED_AT

FROM {{ ref('bronze_hosts') }}