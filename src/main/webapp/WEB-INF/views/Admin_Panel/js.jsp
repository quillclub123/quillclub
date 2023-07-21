   <!-- Placed at the end of the document so the pages load faster -->
	<script src="assets/scripts/jquery.min.js"></script>
	<script src="assets/scripts/modernizr.min.js"></script>
	<script src="assets/plugin/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/plugin/mCustomScrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="assets/plugin/nprogress/nprogress.js"></script>
	<script src="assets/plugin/sweet-alert/sweetalert.min.js"></script>
	<script src="assets/plugin/waves/waves.min.js"></script>
	<!-- Full Screen Plugin -->
	<script src="assets/plugin/fullscreen/jquery.fullscreen-min.js"></script>
	
	<!-- Flex Datalist -->
	<script src="assets/plugin/flexdatalist/jquery.flexdatalist.min.js"></script>

	<!-- Popover -->
	<script src="assets/plugin/popover/jquery.popSelect.min.js"></script>

	<!-- Select2 -->
	<script src="assets/plugin/select2/js/select2.min.js"></script>

	<!-- Multi Select -->
	<script src="assets/plugin/multiselect/multiselect.min.js"></script>
	 
	<!-- Percent Circle -->
	<script src="assets/plugin/percircle/js/percircle.js"></script>

	<!-- Google Chart -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

	<!-- Chartist Chart -->
	<script src="assets/plugin/chart/chartist/chartist.min.js"></script>
	<script src="assets/scripts/chart.chartist.init.min.js"></script>

	<!-- FullCalendar -->
	<script src="assets/plugin/moment/moment.js"></script>
	<script src="assets/plugin/fullcalendar/fullcalendar.min.js"></script>
	<script src="assets/scripts/fullcalendar.init.js"></script>
	
	
	<!-- Data Tables -->
	<script src="assets/plugin/datatables/media/js/jquery.dataTables.min.js"></script>
	<script src="assets/plugin/datatables/media/js/dataTables.bootstrap.min.js"></script>
	<script src="assets/plugin/datatables/extensions/Responsive/js/dataTables.responsive.min.js"></script>
	<script src="assets/plugin/datatables/extensions/Responsive/js/responsive.bootstrap.min.js"></script>
	<script src="assets/scripts/datatables.demo.min.js"></script>
	
	<script src="https://cdn.datatables.net/v/bs5/jszip-2.5.0/dt-1.13.4/af-2.5.3/b-2.3.6/b-html5-2.3.6/b-print-2.3.6/cr-1.6.2/kt-2.8.2/r-2.4.1/sp-2.1.2/datatables.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
 	
 	<!-- <script src="assets/ckeditor/ckeditor.js"></script>    -->

	<script src="assets/scripts/main.min.js"></script>
	<script src="assets/color-switcher/color-switcher.min.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	 
	 <script src="https://cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
	 <script src="https://paul.kinlan.me/ad-inject.js"></script>
	 <!-- CDN for chosen plugin -->
    <script src=
"https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js" 
          crossorigin="anonymous" 
          referrerpolicy="no-referrer">
    </script>
  
    <!-- CDN for multiselect jquery plugin -->
    <script src=
"https://cdnjs.cloudflare.com/ajax/libs/multi-select/0.9.12/js/jquery.multi-select.min.js" 
           crossorigin="anonymous" referrerpolicy="no-referrer">
    </script>
  
    <!-- CDN for CSS of chosen plugin -->
    <link rel="stylesheet" href=
"https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" 
         crossorigin="anonymous" 
         referrerpolicy="no-referrer" />
	
	 <script>
	/*   $(document).ready(function()
		        {            
		            $("#school_name").chosen({
		                max_selected_options: 12,
		                hide_results_on_select: false,
		            });
		        })  */
	  $(document).ready(function()
		        {            
		            $("#selectclass").chosen({
		                // This option restricts the number 
		                  // of items for selection
		                max_selected_options: 12,
		                // This option keeps the dropdown 
		                  // open till the selection
		                hide_results_on_select: false,
		            });
		        })
	// Ensure that CKEditor is loaded before using it
	
	 if (typeof CKEDITOR !== 'undefined') {
      CKEDITOR.replace('mailTemplate', {
      });
    }
	   if (typeof CKEDITOR !== 'undefined') {
      CKEDITOR.replace('question', {
        filebrowserBrowseUrl: '/filebrowser/browse', // Replace with your file browser URL
      });
    }
	   if (typeof CKEDITOR !== 'undefined') {
      CKEDITOR.replace('description', {
      });
    }
	   if (typeof CKEDITOR !== 'undefined') {
      CKEDITOR.replace('termsCondition', {
      });
    }
	  
	 </script>
	 
	 