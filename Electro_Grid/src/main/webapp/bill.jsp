<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electron Grid</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
        integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.0/css/jquery.dataTables.css">

</head>
<style>
    body {
    	overflow-x: hidden;
        margin: 0;
    }
</style>

<body>

    <div class="container-fluid m-0 p-0">
        <div class="row">
            <div class="col-md-12">
                <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #46a5e9;">
                    <a class="navbar-brand font-weight-bold" href="#">Electron Grid App</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav">
                            <a class="nav-link active font-weight-bold" href="index.jsp">Home <span
                                    class="sr-only">(current)</span></a>
                            <a class="nav-link font-weight-bold" href="user.jsp">User</a>
                            <a class="nav-link font-weight-bold" href="bill.jsp">Bill</a>
                        </div>
                    </div>
                </nav>
            </div>
            <div class="col-md-12 p-4">
                <div class="card w-100">
                    <div class="card-body">
                        <h5 class="card-title">Bill Management</h5>
                        <h6 class="card-subtitle mb-2 text-muted mb-3">This section can handle the all bill related
                            operations</h6>

                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <form  id="billForm" class="mb-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="billId">Bill ID</label>
                                                <input type="text" class="form-control form-control-sm" id="billId" disabled>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="userId">User ID</label>
                                                <input type="number" class="form-control form-control-sm" id="userId">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="unitUsage">Unit Usage</label>
                                                <input type="number" class="form-control form-control-sm" id="unitUsage">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="date">Date</label>
                                                <input type="date" class="form-control form-control-sm" id="date">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="unitPrice">Unit Price</label>
                                                <input type="number" class="form-control form-control-sm" id="unitPrice">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="total">Total</label>
                                                <input type="text" class="form-control form-control-sm" id="total">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <button type="button" id="btnSave" class="btn btn-success">Save Bill</button>
                                <button type="button" id="btnEdit" class="btn btn-warning">Edit Bill</button>
                                <button type="button" id="btnDelete" class="btn btn-danger">Delete Bill</button>
                                <div class="alert alert-success mt-2" id="sucessMsg" role="alert"></div>
                                <div class="alert alert-danger mt-2" id="errMsg" role="alert"></div>
                            </div>
                            <div class="col-md-12">
                                <div id="tblbills"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script type="text/javascript" charset="utf8"
        src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            $('#sucessMsg').hide();
            $('#errMsg').hide();
            $('#btnEdit').hide();
            $('#btnDelete').hide();
            getAllBills();

            $('#btnSave').click(function() {
                $('#errMsg').hide();

                if($('#billId').val() == "") {
                    // Save Bill

                    // Validate bill inputs
                    if($('#userId').val() == "") { displayErr("Please Enter User Id!") }
                    else if($('#unitUsage').val() == "") { displayErr("Please Enter Unit Usage!") }
                    else if($('#date').val() == "") { displayErr("Please Enter Bill Date!") }
                    else if($('#unitPrice').val() == "") { displayErr("Please Enter Unit Price!") }
                    else if($('#total').val() == "") { displayErr("Please Enter Total!") }
                    else {
                        var objBill = {
                        		user_id: $('#userId').val(),
                        		unit_usage: $('#unitUsage').val(),
                        		date: $('#date').val(),
                        		unit_price: $('#unitPrice').val(),
                        		total: $('#total').val()
                        }

                        $.ajax({
                            url: 'http://localhost:8080/Electro_Grid/api/bill',
                            method: 'POST',
                            data: JSON.stringify(objBill),
                            contentType: "application/json",
                            success: function (response) {
                                displayMsg("Bill Created Successfully!");
                                $('#userId').val("");
                                $('#unitUsage').val("");
                                $('#date').val("");
                                $('#unitPrice').val("");
                                $('#total').val("");
                                getAllBills();
                                setTimeout(() => {
                                    $('#sucessMsg').html("");
                                    $('#sucessMsg').hide();
                                }, 3000)
                            },
                            error: function (error) {
                                displayErr(JSON.stringify(error));
                            }
                        });
                    }
                } else {
                    // Update Bill
                    
                    // Validate bill inputs
                    if($('#billId').val() == "") { displayErr("Please Enter Bill Id!") }
                    else if($('#userId').val() == "") { displayErr("Please Enter User Id!") }
                    else if($('#unitUsage').val() == "") { displayErr("Please Enter Unit Usage!") }
                    else if($('#date').val() == "") { displayErr("Please Enter Bill Date!") }
                    else if($('#unitPrice').val() == "") { displayErr("Please Enter Unit Price!") }
                    else if($('#total').val() == "") { displayErr("Please Enter Total!") }
                    else {
                        var objBill = {
                        		id: $('#billId').val(),
                        		user_id: $('#userId').val(),
                        		unit_usage: $('#unitUsage').val(),
                        		date: $('#date').val(),
                        		unit_price: $('#unitPrice').val(),
                        		total: $('#total').val()
                        }
                        
                        $.ajax({
                            url: 'http://localhost:8080/Electro_Grid/api/bill',
                            method: 'PUT',
                            data: JSON.stringify(objBill),
                            contentType: "application/json",
                            success: function (response) {
                                displayMsg("Bill Updated Successfully!");
                                $('#billId').val("");
                                $('#userId').val("");
                                $('#unitUsage').val("");
                                $('#date').val("");
                                $('#unitPrice').val("");
                                $('#total').val("");
                                getAllBills();
                                setTimeout(() => {
                                    $('#sucessMsg').html("");
                                    $('#sucessMsg').hide();
                                }, 3000)
                            },
                            error: function (error) {
                                displayErr(JSON.stringify(error));
                            }
                        });
                    }
                }
            });
            
            $('#btnDelete').click(function() {
            	if($('#billId').val() == "") { displayErr("Please Select Bill!") }
            	else {
            		var objBill = { id: $('#billId').val() }
                    $.ajax({
                        url: 'http://localhost:8080/Electro_Grid/api/bill',
                        method: 'DELETE',
                        data: JSON.stringify(objBill),
                        contentType: "application/json",
                        success: function (response) {
                            displayMsg("Bill Deleted Successfully!");
                            $('#billId').val("");
                            $('#userId').val("");
                            $('#unitUsage').val("");
                            $('#date').val("");
                            $('#unitPrice').val("");
                            $('#total').val("");
                            
                            $("#billForm :input").prop("disabled", false);
                        	$( "#billId" ).prop( "disabled", true );
                            $('#btnSave').show();
                            $('#btnDelete').hide();
                            $('#btnEdit').hide();
                            
                            getAllBills();
                            setTimeout(() => {
                                $('#sucessMsg').html("");
                                $('#sucessMsg').hide();
                            }, 3000)
                        },
                        error: function (error) {
                            displayErr(JSON.stringify(error));
                        }
                    });            		
            	}
            });
            
            $('#btnEdit').click(function() {
            	$("#billForm :input").prop("disabled", false);
            	$( "#billId" ).prop( "disabled", true );
            	
                $('#btnSave').show();
                $('#btnDelete').hide();
                $('#btnEdit').hide();
            });
        });
        
        $(document).on("click", ".btnselect", function(event) { 
        	$('#billId').val($(this).closest("tr").find('td:eq(0)').text());
        	$('#userId').val($(this).closest("tr").find('td:eq(1)').text());
        	$('#unitUsage').val($(this).closest("tr").find('td:eq(2)').text());
        	$('#date').val($(this).closest("tr").find('td:eq(3)').text());
        	$('#unitPrice').val($(this).closest("tr").find('td:eq(4)').text());
        	$('#total').val($(this).closest("tr").find('td:eq(5)').text());
        	
        	$("#billForm :input").prop("disabled", true);
        	
            $('#btnSave').hide();
            $('#btnDelete').show();
            $('#btnEdit').show();
       });

        function displayErr(msg) {
            $('#errMsg').show();
            $('#errMsg').html(msg);
        }

        function displayMsg(msg) {
            $('#sucessMsg').show();
            $('#sucessMsg').html(msg);
        }

        function getAllBills() {
        	var table;
            $.ajax({
                url: 'http://localhost:8080/Electro_Grid/api/bill/',
                method: 'GET',
                success: function (response) {
                    $('#tblbills').html(response);
                    var table = $('#dataTable').DataTable();
                },
                error: function (error) {
                    displayErr(JSON.stringify(error));
                }
            });
        }

    </script>
</body>
</html>