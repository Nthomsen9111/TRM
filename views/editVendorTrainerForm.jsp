<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix = "f" uri = "http://www.springframework.org/tags/form"

 %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>edit form</title>
</head>
<body>
<h1>Change Information of Vendor Trainer</h1>
<hr size = "4" color = "blue"/>
<br>
<f:form action = "../saveUpdateVendorTrainerData">
	<f:input path = "vendor_trainer_id"/>
	<f:input path = "vendor_trainer_name"/>
	<f:input path = "phone"/>
	<f:input path = "email"/>
	<f:input path = "profile"/>
	
	<f:input path = "evaulation_status"/>
	<f:input path = "vendor_trainer_log"/>

	<f:button>save</f:button>
</f:form>
<br>	
<hr size = "4" color = "blue"/>

</body>
</html>