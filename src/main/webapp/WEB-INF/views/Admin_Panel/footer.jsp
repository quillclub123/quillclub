<!-- /.row -->		
		<footer class="footer" style="width:80%; position: fixed; bottom: 0;background: whitesmoke; height: 40px;">
			<ul class="list-inline" style="margin-top: -10px; float: right;" >
				<li><span id="year"></span> © <a href="http://www.quillclubwriters.com/" target="_blank">Quill Club Writers</a></li>
				<li><a href="#">Privacy</a></li>
				<li><a href="#">Terms</a></li>
				<li><a href="#">Help</a></li>
			</ul>
		</footer>
		<script>
        // Get the current year
        var currentYear = new Date().getFullYear();
        // Insert the current year into the span with id 'year'
        document.getElementById('year').textContent = currentYear;
    </script>