<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"

</head>

<body style='background-color:blue'>
<title>CTC Global</title>
<h1>Welcome to the DevOps Demo Application v0.</h1>
<p><i>This app is used for demonstrating and testing various sample deployments</i></p>
<h3>Hostname:
                <?php
                echo gethostname();
                ?>
</h3>
  
 <h3>Date and time:
                <?php
                $date = date("D M d, Y G:i");
                echo $date
                ?>
</h3>
</body>
</html>
