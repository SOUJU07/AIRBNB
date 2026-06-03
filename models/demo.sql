{{
  config(
    materialized = 'view',
    )
}}

select * from AIRBNB.STAGING.LISTINGS
