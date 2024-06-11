<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Add New Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            max-width: 800px;
        }

        h2 {
            color: #343a40;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-label {
            color: #495057;
            font-weight: bold;
        }

        .form-control {
            border: 1px solid #ced4da;
            border-radius: 5px;
        }

        .error {
            color: #dc3545;
            font-size: 0.875rem;
        }

        #addLocationButton {
            background-color: #28a745;
            color: #ffffff;
            border: none;
            border-radius: 5px;
        }

        #addLocationButton:hover {
            background-color: #218838;
        }

        .removeLocationButton {
            margin-top: 10px;
        }

        .removeLocationButton {
            background-color: #dc3545;
            color: #ffffff;
            border: none;
            border-radius: 5px;
        }

        .removeLocationButton:hover {
            background-color: #c82333;
        }

        button[type="submit"] {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            border-radius: 5px;
        }

        button[type="submit"]:hover {
            background-color: #0069d9;
        }

        hr {
            border-top: 1px solid #dee2e6;
        }

        .location-entry {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .location-entry h4 {
            color: #495057;
            margin-bottom: 15px;
        }

        @media (max-width: 576px) {
            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Exam</h2>
        <form id="examForm" action="AddExam" method="post">
            <div class="mb-3">
                <label for="examName" class="form-label">Exam Name</label>
                <input type="text" class="form-control" id="examName" name="examName" required>
                <div class="error" id="examNameError"></div>
            </div>
            <div class="mb-3">
                <label for="examDescription" class="form-label">Exam Description</label>
                <textarea class="form-control" id="examDescription" name="examDescription" rows="3" required></textarea>
                <div class="error" id="examDescriptionError"></div>
            </div>
            <div class="mb-3">
                <label for="examDate" class="form-label">Exam Date</label>
                <input type="date" class="form-control" id="examDate" name="examDate" required>
                <div class="error" id="examDateError"></div>
            </div>
            <div class="mb-3">
                <label for="applicationStart" class="form-label">Application Start Date</label>
                <input type="date" class="form-control" id="applicationStart" name="applicationStart" required>
                <div class="error" id="applicationStartError"></div>
            </div>
            <div class="mb-3">
                <label for="applicationEnd" class="form-label">Application End Date</label>
                <input type="date" class="form-control" id="applicationEnd" name="applicationEnd" required>
                <div class="error" id="applicationEndError"></div>
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
                <button type="submit" class="btn btn-primary">Save Exam</button>
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
                <h4>Location \${locationIndex + 1}</h4>
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

        document.getElementById('examForm').addEventListener('submit', function(event) {
            const examDate = new Date(document.getElementById('examDate').value);
            const applicationStart = new Date(document.getElementById('applicationStart').value);
            const applicationEnd = new Date(document.getElementById('applicationEnd').value);
            const today = new Date();
            const threeDaysFromToday = new Date();
            threeDaysFromToday.setDate(today.getDate() + 3);
            const examName = document.getElementById('examName').value;
            const examDescription = document.getElementById('examDescription').value;

            let valid = true;
            document.getElementById('examDateError').innerText = '';
            document.getElementById('applicationStartError').innerText = '';
            document.getElementById('applicationEndError').innerText = '';
            document.getElementById('examNameError').innerText = '';
            document.getElementById('examDescriptionError').innerText = '';
            if (examDate < threeDaysFromToday) {
                document.getElementById('examDateError').innerText = 'The exam date should be at least 3 days from today.';
                valid = false;
            }
            if (applicationStart >= applicationEnd) {
                document.getElementById('applicationStartError').innerText = 'The application start date should be before the application end date.';
                valid = false;
            }
            if (applicationStart >= examDate || applicationEnd >= examDate) {
                document.getElementById('applicationEndError').innerText = 'Both application start and end dates should be before the exam date.';
                valid = false;
            } 
            if (examName.trim().split(/\s+/).length > 20) {
                document.getElementById('examNameError').innerText = 'The exam name should not be more than 20 words.';
                valid = false;
            }
            if (examDescription.trim().split(/\s+/).length > 50) {
                document.getElementById('examDescriptionError').innerText = 'The exam description should not be more than 50 words.';
                valid = false;
            }
            if (!valid) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>
