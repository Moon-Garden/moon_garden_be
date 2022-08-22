<div id="top"></div>


<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://moon-garden-fe.herokuapp.com/" target="_blank" rel="noopener noreferrer"><img src="https://raw.githubusercontent.com/Moon-Garden/moon_garden_fe/main/public/moon-garden-logo.svg" alt="logo" width="30%"/></a>
</div>

  <p align="center">
    <a href="https://moon-garden-fe.herokuapp.com/"><strong>Checkout Moon Garden Here! »</strong></a>
  </p>
  <p align="center">
    <a href="https://github.com/Moon-Garden/moon_garden_fe"><strong>Explore the Moon Garden Frontend Application »</strong></a>
  </p>
</div>



[![CircleCI](https://dl.circleci.com/status-badge/img/gh/Moon-Garden/moon_garden_be/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/Moon-Garden/moon_garden_be/tree/main)  

If this is green then the API is in good shape. 

---

# API Usage
- Base URL:     `https://moon-garden-be.herokuapp.com`


- Available Endpoints:
	- [User Endpoints](#USER)
	- [Garden Endpoints](#GARDEN)
	- [Plant Endpoints](#PLANT)



---

# USER


**Login User/ Create and login**

- This endpoint consumes data returned from Google OAuth, looks for a user, and if no user exists creates one. 
	

``` ruby
[POST] /api/v1/find_or_create_user


Required PARAMS: 
 - _json: google_OAuth_data.to_json
```

 Example:

``` ruby 
[POST] /api/v1/find_or_create_user

 - Params: 
	 - _json : "{\"name\":\"Jennifer \",\"email\":\"jennnnnn@gmail.com\",\"unverified_email\":\"jennsssrlhalloran@gmail.com\",\"email_verified\":true,\"first_name\":\"Jennifer\",\"last_name\":\"Halloan\",\"image\":\"https://lh3.googleusercontent.com/a-/AFdZucr_zffBdhJaydFkdXeeHkhe2BzmVNKGIE-Ozwh=s96-c\"}"
```

RESPONSE:

```json
{
	"data": {
		"id": "3",
		"type": "user",
		"attributes": {
			"name": "Jennifer ",
			"email": "jennnnnn@gmail.com",
			"image": 
 "https://lh3.googleusercontent.com/a-/AFdZucr_zffBdhJaydFkdXeeHkhe2BzmVNKGIE-Ozwh=s96-c"
		}
	}
}
```
---


**Find User**

- This endpoint finds an existing user, based on user id

``` ruby
[GET] /api/v1/users/:id
```

RESPONSE:

```json
{
	"data": {
		"id": "3",
		"type": "user",
		"attributes": {
			"name": "Jennifer ",
			"email": "jennnnnn@gmail.com",
			"image": 
 "https://lh3.googleusercontent.com/a-/AFdZucr_zffBdhJaydFkdXeeHkhe2BzmVNKGIE-Ozwh=s96-c"
		}
	}
}
``````
---


# Garden


**Create Garden**

- This endpoint creates a garden for a user 
	

``` ruby
[POST] /api/v1/users/:id/gardens


Required PARAMS: 
 - _json: user_data.to_json
```

 Example:

``` ruby 
[POST] /api/v1/users/:id/gardens

 - Params: 
	 - _json : "{\"user_id\":1,\"name\":\"Summer Garden\",\"notes\":\"it's too damn hot\",\"cardinal_direction\":1}"
```

RESPONSE:

```json
{
	"data": {
		"id": "2",
		"type": "garden",
		"attributes": {
			"name": "Summer Garden",
			"cardinal_direction": "South",
			"notes": "it's too damn hot"
		}
	}
}
```
---


**User Gardens**

- This endpoint returns all the gardens for a user
	

``` ruby
[GET] /api/v1/users/:user_id/gardens
```


RESPONSE:

```json
{
	"data": [
		{
			"id": "1",
			"type": "garden",
			"attributes": {
				"name": "Summer Garden",
				"cardinal_direction": "South",
				"notes": "it's too damn hot"
			}
		},
		{
			"id": "2",
			"type": "garden",
			"attributes": {
				"name": "Summer Garden",
				"cardinal_direction": "South",
				"notes": "it's too damn hot"
			}
		}
	]
}
```
---

**Garden Show**

- This endpoint returns a particular garden
	

``` ruby
[GET] /api/v1/users/:user_id/gardens
```


RESPONSE:

```json
{
	"data": {
		"id": "2",
		"type": "garden",
		"attributes": {
			"name": "Summer Garden",
			"cardinal_direction": "South",
			"notes": "it's too damn hot"
		}
	}
}
```
---
**Garden Destroy**

- This endpoint destroys a particular garden
	

``` ruby
[DELETE] /api/v1/users/:user_id/gardens/:id
```


RESPONSE:

```json
No Response
```
---
**Garden Update**

- This endpoint updates a particular garden
	

``` ruby
[PATCH] /api/v1/users/:user_id/gardens/:id
```

 Example:

``` ruby 
[PATCH] /api/v1/users/:user_id/gardens/:id


 - Params: 
	 - _json : "{\"name\":\"Summer Garden\",\"notes\":\"it's too damn hot\",\"cardinal_direction\":1}"
```

RESPONSE:

```json
{
	"data": {
		"id": "2",
		"type": "garden",
		"attributes": {
			"name": "Summer Garden",
			"cardinal_direction": "South",
			"notes": "it's too damn hot"
		}
	}
}
```
---



# Plant


**Create Plant**

- This endpoint creates a garden for a user 
	

``` ruby
[POST]  /api/v1/users/:user_id/gardens/:garden_id/plants


Required PARAMS: 
 - _json: plant_data.to_json
```

 Example:

``` ruby 
[POST]  /api/v1/users/:user_id/gardens/:garden_id/plants

 - Params: 
	 - _json: "{\"user_id\":\"1\",\"garden_id\":\"1\",\"name\":\"Carrot\",\"plant_id\":\"sae2340987dage\"}"
```

RESPONSE:

```json
{
	"data": {
		"id": "2",
		"type": "plant",
		"attributes": {
			"name": "Carrot",
			"plant_id": "sae2340987dage",
			"date_planted": null,
			"moon_phase": null,
			"date_matured": null,
			"bounty_amount": null,
			"pruning_behaviors": null,
			"notes": null,
			"garden_id": 1
		}
	}
}
```
---


**Garden Plants**

- This endpoint returns all the plants for a garden
	

``` ruby
[GET] /api/v1/users/:user_id/gardens/:garden_id/plants
```

RESPONSE:

```json
{
	"data": [
		{
			"id": "1",
			"type": "plant",
			"attributes": {
				"name": "Carrot",
				"plant_id": "sae2340987dage",
				"date_planted": null,
				"moon_phase": null,
				"date_matured": null,
				"bounty_amount": null,
				"pruning_behaviors": null,
				"notes": null,
				"garden_id": 1
			}
		},
		{
			"id": "2",
			"type": "plant",
			"attributes": {
				"name": "Carrot",
				"plant_id": "sae2340987dage",
				"date_planted": null,
				"moon_phase": null,
				"date_matured": null,
				"bounty_amount": null,
				"pruning_behaviors": null,
				"notes": null,
				"garden_id": 1
			}
		}
	]

}
```
---

**Plant Show**

- This endpoint returns a particular plant
	

``` ruby
[GET] /api/v1/users/:user_id/gardens/:garden_id/plants/:id
```

RESPONSE:

```json
{
	"data": {
		"id": "2",
		"type": "plant",
		"attributes": {
			"name": "Carrot",
			"plant_id": "sae2340987dage",
			"date_planted": null,
			"moon_phase": null,
			"date_matured": null,
			"bounty_amount": null,
			"pruning_behaviors": null,
			"notes": null,
			"garden_id": 1
		}
	}
}
```
---
**Plant Destroy**

- This endpoint destroys a particular plant
	

``` ruby
[DELETE] /api/v1/users/:user_id/gardens/:garden_id/plants/:id
```

RESPONSE:

```json
No Response
```
---
**Plant Update**

- This endpoint updates a particular plant
	

``` ruby
[PATCH] /api/v1/users/:user_id/gardens/:garden_id/plants/:id
```

 Example:

``` ruby 
[PATCH] /api/v1/users/:user_id/gardens/:garden_id/plants/:id


 - Params: 
	 - _json : "{\"moon_phase\":\"Full\"}"
```

RESPONSE:

```json
{
	"data": {
		"id": "2",
		"type": "plant",
		"attributes": {
			"name": "Carrot",
			"plant_id": "sae2340987dage",
			"date_planted": null,
			"moon_phase": "Full",
			"date_matured": null,
			"bounty_amount": null,
			"pruning_behaviors": null,
			"notes": null,
			"garden_id": 1
		}
	}
}
```
---

# Feel like contributing??



<img src="https://user-images.githubusercontent.com/85247765/182939845-58e20d6b-c710-4fc5-8ea3-c4345f38025d.png" width="600" height="300">
Note: "plant_id" in the plant table is referencing the id from an outside api.



## Installation

1. Clone this directory to your local repository using the SSH key:

```

$ git clone git@github.com:Moon-Garden/moon_garden_be.git

```

  

2. Install gems for development using [Bundler](https://bundler.io/guides/using_bundler_in_applications.html#getting-started---installing-bundler-and-bundle-init):

```

$ bundle install

```

  

3. Set up your database with:

```

$ rails db:{drop,create,migrate,seed}

```

  

4. Run the test suite with:

```

$ bundle exec rspec

```

  

5. Run your development server with:

```

$ rails s

```

  

6. In your browser, visit ['localhost:3000/`](http://localhost:3000/) to see the app in action.

7. Contribute away!


![ScreenShot](https://media1.giphy.com/media/l3E6z6QxD2uKoRTDq/giphy.gif?cid=ecf05e47o1mzgsf1ssz1ovbc62vz9k7pm0xiuot6kqhwfqex&rid=giphy.gif&ct=g) 




# Contributors

<table>

  <tr>
   <td align="center"><a href="https://github.com/jimriddle1"><img src="https://avatars.githubusercontent.com/u/99755958?v=4" width="100px;" alt=""/><br /><sub><b>Jim R.  (he/him)</b></sub></a><br /><a href="https://www.linkedin.com/in/jim-riddle-b6718037/" title ="Linked In"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a></td>

   <td align="center"><a href="https://github.com/devAndrewK/"><img src="https://media-exp1.licdn.com/dms/image/C4E03AQFWtQ3Z48P8ng/profile-displayphoto-shrink_200_200/0/1649703988715?e=1665014400&v=beta&t=mTFNRWT5IIgNrV9E53BxaI-N6rA6mP13d279OYD4cCE" width="100px;" alt=""/><br /><sub><b>Andrew K. (he/him)</b></sub></a><br /><a href="https://www.linkedin.com/in/andrewkingdev/" title ="Linked In"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a></td>

   <td align="center"><a href="https://github.com/casefaz"><img src="https://avatars.githubusercontent.com/u/98674727?v=4" width="100px;" alt=""/><br /><sub><b>Casey F. (they/she)</b></sub></a><br /><a href="https://www.linkedin.com/in/casey-fazio-7ba04149/" title ="Linked In"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a></td>

   <td align="center"><a href="https://github.com/jenniferhalloran"><img src="https://avatars.githubusercontent.com/u/48455658?v=4" width="100px;" alt=""/><br /><sub><b>Jennifer H. (she/her)</b></sub></a><br /><a href="https://www.linkedin.com/in/jenniferlhalloran/" title ="Linked In"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a></td>

   <td align="center"><a href="https://github.com/bwbolt"><img src="https://avatars.githubusercontent.com/u/85247765?v=4" width="100px;" alt=""/><br /><sub><b>Bryce W. (he/him)</b></sub></a><br /><a href="https://www.linkedin.com/in/bryce-wein/" title ="Linked In"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a></td>

   <td align="center"><a href="https://github.com/StephenWilkens"><img src="https://avatars.githubusercontent.com/u/98788282?v=4" width="100px;" alt=""/><br /><sub><b>Stephen W. (he/him)</b></sub></a><br /><a href="https://www.linkedin.com/in/stephen-wilkens/" title ="Linked In"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a></td>


  </tr>
</table>

