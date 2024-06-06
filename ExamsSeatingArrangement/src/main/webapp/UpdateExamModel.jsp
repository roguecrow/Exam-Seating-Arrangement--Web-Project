<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<div class="modal fade" id="addExamModal" tabindex="-1" role="dialog" aria-labelledby="addExamModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addExamModalLabel">Add New Exam</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addExamForm" action="AddExam" method="post"> 
                    <div class="form-group">
                        <label for="examName">Exam Name</label>
                        <input type="text" class="form-control" id="examName" name="examName" required>
                    </div>
                    <div class="form-group">
                        <label for="examDescription">Exam Description</label>
                        <textarea class="form-control" id="examDescription" name="examDescription" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="examDate">Exam Date</label>
                        <input type="date" class="form-control" id="examDate" name="examDate" required>
                    </div>
                    <div class="form-group">
                        <label for="applicationStart">Application Start Date</label>
                        <input type="date" class="form-control" id="applicationStart" name="applicationStart" required>
                    </div>
                    <div class="form-group">
                        <label for="applicationEnd">Application End Date</label>
                        <input type="date" class="form-control" id="applicationEnd" name="applicationEnd" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary" form="addExamForm">Save Exam</button>
            </div>
        </div>
    </div>
</div>