# Bilbioteca-API-BE

A backend Ruby on Rails app purely for API.
Make use of seeds.rb to pre-populate database records.

# User Endpoints:

1. Register

```
POST '/auth'
```

Make sure your request to this endpoint is 'application/json' and payload  contains - 'name', 'email', 'password'

2. Login

```
POST '/auth/sign_in'
```

Your request to this endpoint must be 'application/json' and payload must have two keys - 'email', 'password'
Success response from this endpoint will hold 3 important header - 'access-token', 'uid', 'client'
Use these header values for your further

3. Log out

```
DELETE '/auth/sign_out'
```

Your request to this endpoint must be 'application/json' and payload must have three keys - 'access-token', 'uid', 'client'
On successful logout you will recieve a confirmation

# Books Endpoints:

Your requests to the following endpoints must be 'application/json' and must contain these three headers 'access-token', 'uid', 'client' which you received in login response for authentication

1. List out books for current user

```
GET '/books'
```
Success Response will hold the list of books of current user.

2. Fetch a book

```
GET '/books/:id'
```

Success Response will hold the book which matches the id.

3. Create a new Book

```
POST '/books'
```

Your payload to this endpoint must have 'title' in order to create a new book

4. Edit a book

```
PUT '/books/:id'
```

Your payload to this endpoint must have 'title' in order to update a existing book

5. Delete a book

```
DELETE '/books/:id'
```

6. Fetch users who own the book

```
GET '/books/:id/users'
```

Success response will give you a list of users who own the book.

# Group Endpoints:

Your requests to the following endpoints must be 'application/json' and must contain these three headers 'access-token', 'uid', 'client' which you received in login response for authentication

1. List out groups for current user

```
GET '/groups'
```

Success Response will hold the list of groups the current user is in.

2. Fetch a group

```
GET '/groups/:id'
```

Success Response will hold the group which matches the id.

3. Create a new Group

```
POST '/group'
```

Your payload to this endpoint must have 'name' in order to create a new group

4. Edit a group

```
PUT '/groups/:id'
```

Your payload to this endpoint must have 'name' in order to update a existing group

5. Delete a group

```
DELETE '/groups/:id'
```

6. Fetch users of the group

```
GET '/groups/:id/users'
```

Success response will give you a list of users who are in the group.

7. Fetch books of the group

```
GET '/groups/:id/books'
```

Success response will give you a list of books of all the users who are in the group.





