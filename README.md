# TEA SERVICE README

## Description

Tea Service is an a solo practice Rails API application meant to simulate "take-home" challenges with future employment prospects. The challenge specifications can be found [here](https://mod4.turing.edu/projects/take_home/take_home_be).

---

## Local Setup

### Requirements

- Ruby 2.7.4
- Rails 5.2.8

### Steps

1. Clone this repository: `git clone git@github.com:musselmanth/tea_service.git`
2. Navigate to directory: `cd tea_service`
3. Install dependencies: `bundle install`
4. Setup PostgreSQL Database and seed with mock data: `rails db:{create,migrate,seed}`
5. Start local puma server to hit endpoints at http://localhost:3000/api/v1 : `rails server`

---

## Database Schema Diagram

<img src="readme_assets/dbdiagram.png" width="750px">

---

## API Endpoints

### Index

- [Get a Cusomtomer's Tea Subscriptions](#get-a-customers-tea-subscriptions)
- [Subscribe A Customer to a Subscription](#subscribe-a-customer-to-a-subscription)
- [Cancel A Customer's Subscription](#cancel-a-customers-subscription)
  <br><br>

> ## Get a Customer's Tea Subscriptions
>
> GET `/api/v1/customers/<customer_id>/subscriptions`
>
> Example Response:
>
> ```JSON
> {
>   "data": [
>
>   ]
> }
> ```
>
> [Back To Top](#api-endpoints)

<br><br>

> ## Subscribe A Customer to a Subscription
>
> POST `/api/v1/customers/<customer_id>/subscriptions`
>
> Example Response:
>
> ```JSON
> {
>   "data": {
>
>   }
> }
> ```
>
> [Back To Top](#api-endpoints)

<br><br>

> ## Cancel A Customer's Subscription
>
> PATCH `/api/v1/customers/<customer_id>/subscriptions/<subscription_id>`
>
> Example Response:
>
> ```JSON
> {
>   "data": {
>
>   }
> }
> ```
>
> [Back To Top](#api-endpoints)

<br><br>

---
