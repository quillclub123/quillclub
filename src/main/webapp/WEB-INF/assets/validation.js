
  function VerifyPhoneNumber() {
      const passwordPattern = /^(?:(?:\+|0{0,2})91(\s*|[\-])?|[0]?)?([6789]\d{2}([ -]?)\d{3}([ -]?)\d{4})$/;
      var password = userphone; // Replace with the password you want to test

      if (passwordPattern.test(password)) {
          return true;
      } else {
          return false;
      }
  }
  function VerifyEmail() {
      const passwordPattern = /^[^\s@@]+@@[^\s@@]+\.[^\s@@]+$/;
      var password = useremail; // Replace with the password you want to test

      if (passwordPattern.test(password)) {
          return true;
      } else {
          return false;
      }
  }
  function VerifySalary() {
      const passwordPattern = /^(?!0+(?:\.0+)?$)[0-9]+(?:\.[0-9]+)?$/;
      var password = usersalary; // Replace with the password you want to test

      if (passwordPattern.test(password)) {
          return true;
      } else {
          return false;
      }
  }
  
 /*Only Characters and Number are allowed */
        $(function () {
            $(".verifypassword").keypress(function (e) { 
                var keyCode = e.keyCode || e.which;
    
                 /* $("#lblError").html(""); */
    
                //Regex for Valid Characters i.e. Alphabets.
                    const passwordPattern = /^(?:(?:\+|0{0,2})91(\s*|[\-])?|[0]?)?([6789]\d{2}([ -]?)\d{3}([ -]?)\d{4})$/;
    
                //Validate TextBox value against the Regex.
                var isValid = passwordPattern.test(String.fromCharCode(keyCode));
                /* if (!isValid) {
                    $("#lblError").html("Only Alphabets allowed.");
                } */
    
                return isValid;
             })
         });
        