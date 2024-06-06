
<div class="modal fade" id="updateExamModal" tabindex="-1" role="dialog" aria-labelledby="updateExamModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateExamModalLabel">Update Exam Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="updateExamForm" action="UpdateExam" method="post"> 
                    <div class="form-group">
                        <label for="examName">Exam Name</label>
                        <input type="text" class="form-control" id="examName" name="examName" readonly>
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
                <button type="submit" class="btn btn-primary" form="updateExamForm">Save Changes</button>
            </div>
        </div>
    </div>
</div>
