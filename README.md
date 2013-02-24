WHEN AND WHERE GOLF API

# Get all courses:
curl -i -X GET http://localhost:3001/courses

# Get wine with _id value of 50e11e57477869002c000001 (use a value that exists in your database):
curl -i -X GET http://localhost:3001/course/50e11e57477869002c000001

# Delete wine with _id value of 512939d890876f0000000001:
curl -i -X DELETE http://localhost:3001/course/512939d890876f0000000001

# Add a new wine:
curl -i -X POST -H 'Content-Type: application/json' -d '{"name": "Newest Course", "city": "Indianapolis"}' http://localhost:3000/course

# Modify wine with _id value of 512a49bcb70bdd110d000001:
curl -i -X PUT -H 'Content-Type: application/json' -d '{"name": "Edit Course", "city": "Carmel"}' http://localhost:3001/course/512a49bcb70bdd110d000001