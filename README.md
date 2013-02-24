WHEN AND WHERE GOLF API

# Get all courses:
curl -i -X GET http://localhost:3001/courses

# Get wine with _id value of 512a744c81b094982c000001 (use a value that exists in your database):
curl -i -X GET http://localhost:3001/course/512a744c81b094982c000001

# Delete wine with _id value of 512a57dbcc88f5e306000001:
curl -i -X DELETE http://localhost:3001/course/512a57dbcc88f5e306000001

# Add a new wine:
curl -i -X POST -H 'Content-Type: application/json' -d '{"name": "Newest Course", "city": "Indianapolis"}' http://localhost:3001/course

# Modify wine with _id value of 512a7c9d1aac518643000001:
curl -i -X PUT -H 'Content-Type: application/json' -d '{"name": "Edit Course", "city": "Carmel"}' http://localhost:3001/course/512a7c9d1aac518643000001