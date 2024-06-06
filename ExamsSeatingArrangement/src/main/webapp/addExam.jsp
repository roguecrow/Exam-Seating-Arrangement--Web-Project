<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Add New Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Exam</h2>
        <form action="AddExam" method="post">
            <div class="mb-3">
                <label for="examName" class="form-label">Exam Name</label>
                <input type="text" class="form-control" id="examName" name="examName" required>
            </div>
            <div class="mb-3">
                <label for="examDescription" class="form-label">Exam Description</label>
                <textarea class="form-control" id="examDescription" name="examDescription" rows="3" required></textarea>
            </div>
            <div class="mb-3">
                <label for="examDate" class="form-label">Exam Date</label>
                <input type="date" class="form-control" id="examDate" name="examDate" required>
            </div>
            <div class="mb-3">
                <label for="applicationStart" class="form-label">Application Start Date</label>
                <input type="date" class="form-control" id="applicationStart" name="applicationStart" required>
            </div>
            <div class="mb-3">
                <label for="applicationEnd" class="form-label">Application End Date</label>
                <input type="date" class="form-control" id="applicationEnd" name="applicationEnd" required>
            </div>
            <div id="locations-container">
                <h4>Location 1</h4>
                <div class="mb-3">
                    <label for="city" class="form-label">City</label>
                    <input type="text" class="form-control" id="city" name="locations[0].city" required>
                </div>
                <div class="mb-3">
                    <label for="venueName" class="form-label">Venue Name</label>
                    <input type="text" class="form-control" id="venueName" name="locations[0].venueName" required>
                </div>
                <div class="mb-3">
                    <label for="hallName" class="form-label">Hall Name</label>
                    <input type="text" class="form-control" id="hallName" name="locations[0].hallName" required>
                </div>
                <div class="mb-3">
                    <label for="capacity" class="form-label">Capacity</label>
                    <input type="number" class="form-control" id="capacity" name="locations[0].capacity" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="locations[0].address" required>
                </div>
                <div class="mb-3">
                    <label for="locationUrl" class="form-label">Location URL</label>
                    <input type="text" class="form-control" id="locationUrl" name="locations[0].locationUrl" required>
                </div>
            </div>
            <input type="hidden" id="locationIndex" name="locationIndex" value="1">
             <div class="d-flex justify-content-end">
             <button type="button" class="btn btn-secondary me-3" id="addLocationButton">Add Another Location</button>
             <button type="submit" class="btn btn-primary ">Save Exam</button>
             </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <script>
     
    var locationIndex = 1;
        document.getElementById('addLocationButton').addEventListener('click', function() {
            const container = document.getElementById('locations-container');
            const newLocation = document.createElement('div');
            newLocation.classList.add('location-entry');
            newLocation.innerHTML = `
                <h4>Location \${locationIndex + 1} </h4>
                <div class="mb-3">
                    <label for="city" class="form-label">City</label>
                    <input type="text" class="form-control" id="city" name="locations[\${locationIndex}].city" required>
                </div>
                <div class="mb-3">
                    <label for="venueName" class="form-label">Venue Name</label>
                    <input type="text" class="form-control" id="venueName" name="locations[\${locationIndex}].venueName" required>
                </div>
                <div class="mb-3">
                    <label for="hallName" class="form-label">Hall Name</label>
                    <input type="text" class="form-control" id="hallName" name="locations[\${locationIndex}].hallName" required>
                </div>
                <div class="mb-3">
                    <label for="capacity" class="form-label">Capacity</label>
                    <input type="number" class="form-control" id="capacity" name="locations[\${locationIndex}].capacity" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="locations[\${locationIndex}].address" required>
                </div>
                <div class="mb-3">
                    <label for="locationUrl" class="form-label">Location URL</label>
                    <input type="text" class="form-control" id="locationUrl" name="locations[\${locationIndex}].locationUrl" required>
                </div>
                <button type="button" class="btn btn-danger removeLocationButton">Remove Location</button>
                <hr>
            `;
            
            container.appendChild(newLocation);
            locationIndex++;

            newLocation.querySelector('.removeLocationButton').addEventListener('click', function() {
                newLocation.remove();
                locationIndex--;
                updateLocationHeadings();
            });
            document.getElementById('locationIndex').value = locationIndex;

        });

        function updateLocationHeadings() {
            const locations = document.querySelectorAll('.location-entry h4');
            locations.forEach((location, index) => {
                location.innerText = `Location ${index + 1}`;
            });
        }
    </script>
</body>
</html>



