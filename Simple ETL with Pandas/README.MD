# Simple ETL with Pandas

## Overview

In this project, we were asked to process the data of registrants for a hackathon organized by DQLab called DQThon.

This dataset consists of 5000 rows of data (5000 registrants) in CSV (Comma-separated values) format and has several columns including:
1. **participant_id**: ID of the participant/participant of the hackathon. This column is unique so each participant must have a different ID
2. **first_name**: participant's first name
3. **last_name**: participant's last name
4. **birth_date**: participant's date of birth
5. **address**: participant's residence address
6. **phone_number**: participant's cellphone/phone number
7. **country**: participant's country of origin
8. **institute**: the current participating institution, can be the name of the company or the name of the university
9. **occupation**: participant's current job
10. **register_time**: the time participants register for the hackathon in seconds

However, this project will be asked to generate several columns by utilizing existing columns, so that the end of this project is the result of data transformation with several new columns apart from the 10 columns above.

## Conclusion
If you look back, the current dataset is different from the previous extract process. There are some additional columns that take advantage of other column values.

The current dataset contains the following columns:
1. **participant_id**: ID of the participant/participant of the hackathon. This column is unique so each participant must have a different ID
2. **first_name**: participant's first name
3. **last_name**: participant's last name
4. **birth_date**: participant's date of birth (already formatted to YYYY-MM-DD)
5. **address**: participant's residence address
6. **phone_number**: participant's cellphone/phone number
7. **country**: participant's country of origin
8. **institute**: the current participating institution, can be the name of the company or the name of the university
9. **occupation**: participant's current job
10. **register_time**: the time participants register for the hackathon in seconds
11. **team_name**: name of the participating team (combination of first name, last name, country, and institution)
12. **postal_code**: participant's address postal code (taken from the address field)
13. **city**: participant city (taken from the address column)
14. **github_profile**: link of participant's github profile (combination of first name and last name)
15. **email**: participant's email address (combination of first name, last name, institution and country)
16. **cleaned_phone_number**: participant's cellphone/telephone number (already more in line with the phone number format)
17. **register_at**: date and time participants registered (already in DATETIME format)