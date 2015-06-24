<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Enforcement Reports</title>

<link rel="stylesheet" href="assets/libs/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.css" />
<script src="assets/libs/bootstrap/bootstrap.min.js"></script>
<script src="assets/js/jquery-2.1.4.js"></script>
<!-- jQuery -->
<!-- DataTables -->
<script type="text/javascript" src="assets/js/jquery-dataTables.js"></script>
<script>
  $(document).foundation();
 </script>
<script>
	var openFdaEnforcementSite='https://api.fda.gov/food/enforcement.json';
	var openFdaApiKey='?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB';
	var openFdaSearchFoodEnforcements='&search=report_date:[20140101+TO+20150624]';
	var openFdaLimit='&limit=100';
	
	$(document).ready(function(){
		retrieveResults() ;	
	});
	
	function retrieveResults() {
		
		var fdaUrl=openFdaEnforcementSite + openFdaApiKey + openFdaLimit + openFdaSearchFoodEnforcements;
		
		//alert(fdaUrl);
		
		$.ajax( {
			url: fdaUrl,
			type:"GET",
			dataType:"json"
		} )
		.done(function( data) {
			console.log(data);
			processResult(data);
		} )
		.fail(function( data) {
			$("body").css("cursor", "default");
			if( data.statusText == "Not Found")
			{
				alert("Search found no results");
			}
		} );
	}

	function processResult(data) {
			var metaTotal = data.results.length;
			var dataArray = new Array();
			for( var ndx = 0; ndx < metaTotal; ndx++) {
				var rowArray = new Array();
				var recallNumber = "";
				var reasonforRecall = "";
				var status = "";
				var thisRow = data.results[ndx];
				//alert(thisRow.recall_number);
				rowArray.push(thisRow.product_description);
	           	rowArray.push(thisRow.code_info);
	           	rowArray.push(thisRow.classification);
	           	rowArray.push(thisRow.reason_for_recall);
	           	rowArray.push(thisRow.recalling_firm);
				rowArray.push(thisRow.distribution_pattern);
				rowArray.push("Details");
				dataArray.push(rowArray);
			}
			// Generate the data table
			$('#tblResults').DataTable( { 
				data: dataArray
			 } );
		}

</script>
<style>
/* Max width before this PARTICULAR table gets nasty. This query will take effect for any screen smaller than 760px and also iPads specifically. */
@media 
only screen and (max-width: 760px),
(min-device-width: 768px) and (max-device-width: 1024px)  {

	/* Force table to not be like tables anymore */
	table, thead, tbody, th, td, tr { display: block; }
	
	/* Hide table headers (but not display: none;, for accessibility) */
	table.product thead tr { position:absolute; top:-9999px; left:-9999px; }
	table.product tr { border:1px solid #ccc; }
	table.product td { border:none; border-bottom:1px solid #eee; position:relative; padding-left:40%; }
	table.product td:before { position: absolute; top:6px; left:6px; width:45%; padding-right:10px; white-space:nowrap; }
	
	/* Label the data */
	table.product td:nth-of-type(1):before { content: "Product Description"; font-weight:bold; }
	table.product td:nth-of-type(2):before { content: "Code Info"; font-weight:bold; }
	table.product td:nth-of-type(3):before { content: "Classification"; font-weight:bold; }
	table.product td:nth-of-type(4):before { content: "Reason for Recall"; font-weight:bold; }
	table.product td:nth-of-type(5):before { content: "Recalling Firm"; font-weight:bold; }
	table.product td:nth-of-type(6):before { content: "Distribution Pattern"; font-weight:bold; }
	table.product td:nth-of-type(7):before { content: "Event Details"; font-weight:bold; }
}
</style>

</head>
<body>

<div id="page-wrap">
    
    <div class="page-banner"><img src="assets/images/banner.jpg" class="img-responsive" alt="Banner" /></div>

	<div class="page-content">
	<h1>Enforcement Reports - Recall Information for Food</h1>
  
	<p>This is the openFDA API endpoint for all food product recalls monitored by the FDA. When an FDA-regulated product is either defective or potentially harmful, recalling that product - removing it from the market or correcting the problem - is the most effective means for protecting the public.</p>
    <p>Recalls are almost always voluntary, meaning a company discovers a problem and recalls a product on its own. Other times a company recalls a product after FDA raises converns. Only in rare cases will FDA request or order a recall. But in every case, FDA's role is to oversee a company's strategy, classify the recalled products according to the level of hazard involved, and assess the adequacy of the recall. Recall information is posted in the Enforcement Reports once the products are classified.</p>
    
    <div class="page-filter">
    	<div class="page-filterKeywords">
            <p><strong>Filter Results by Keyword(s):</strong></p>
            <div class="input">
                <input type="search" class="form-control" placeholder="<chicken> or <chicken Maryland>">
            </div>
        </div>
        <div class="page-filterDate">
        	<p><strong>Search Reported Date (max range 1 month)</strong></p>
        </div>
        <button type="submit" class="btn btn-default">Search</button>
    </div>
    
    <div class="panel panel-warning">
        <div class="panel-body">
        	<span class="glyphicon glyphicon-exclamation-sign"></span> Results displayed are from <strong>05/24/15</strong> to <strong>06/24/15</strong>
        </div>
    </div>
    
    <ul class="nav nav-pills">
        <li role="presentation" class="active"><a href="#">Product View</a></li>
        <li role="presentation"><a href="#">Download CSV</a></li>
        <li role="presentation" class="disabled"><a href="#">Download XML</a></li>
        <li role="presentation" class="disabled"><a href="#">Print-Friendly View</a></li>
    </ul>
	<table class="product" summary="" id="tblResults">
		<thead>
		<tr>
			<th scope="row">Product Description</th>
			<th scope="row">Code Info</th>
			<th scope="row">Classification</th>
			<th scope="row">Reason for Recall</th>
			<th scope="row">Recalling Firm</th>
            <th scope="row">Distribution Pattern</th>
            <th scope="row">Event Details</th>
		</tr>
		</thead>
	</table>
    </div>
	
    <footer class="footer"></footer>

</div>
		
</body>
</html>