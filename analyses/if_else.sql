{% set flag = 1 %}

select * from {{ ref('bronze_bookings') }}
{% if flag==1 %}
    where nights_booked = 3
{% else %}
    where nights_booked = 6
{% endif %}