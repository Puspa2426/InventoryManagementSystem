<%@ taglib uri = 'http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<fmt:setTimeZone value='GMT+8' />
<%@ page contentType='text/html' pageEncoding='UTF-8' %>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.1//EN' 'http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml' lang='en-MY'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' charset='UTF-8' />
<meta name='viewport' content='width=device-width, initial-scale=1.0' />
<title>Inventory Management System</title>

<!-- greybox used for pop-up dialog window -->
<script type='text/javascript'>
    var GB_ROOT_DIR = './greybox/'
</script>
<script type='text/javascript' src='greybox/AJS.js'></script>
<script type='text/javascript' src='greybox/AJS_fx.js'></script>
<script type="text/javascript" src='greybox/gb_scripts.js'></script>
<link href='greybox/gb_styles.css' rel='stylesheet' type='text/css' media='all' />

<link rel='shortcut icon' type='image/png' href='images/favicon.png' />
<link rel='stylesheet' href='css/components.css' />
<link rel='stylesheet' href='css/icons.css' />
<link rel='stylesheet' href='css/responsee.css' />
<!---<link href='css/fonts.css' rel='stylesheet' type='text/css' />--->

<script type='text/javascript' src='js/jquery-1.8.3.min.js' /></script>
<script type='text/javascript' src='js/jquery-ui.min.js' /></script>
<style type='text/css'>
.links:hover { color: red }

.buttons
{
	display: inline-block;
  	padding: 5px 5px;
  	cursor: pointer;
  	text-align: center;
  	text-decoration: none;
  	outline: none;
  	color: #fff;
  	background-color: blue;
  	border: none;
  	border-radius: 9px;
  	box-shadow: 0 3px #333; 
}

.buttons:hover {background-color: #3e8e41}

.buttons:active
{
  background-color:#333;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}

.bottomLogo
{
	position: absolute;
	bottom: 0px;
	left: 130px;
	padding: 8px;
}

.footer
{
	position: fixed;
	bottom: 0px;
	width: 100%;
	left: 0px;
	padding: 8px;
	background-color: #FF9933;
}
</style>
</head>
