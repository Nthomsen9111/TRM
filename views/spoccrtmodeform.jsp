<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Classroom Training Mode</title>
</head>
<body>
<h1>Classroom Training Mode</h1>
<hr size="4" color="black"/>
<br>
<f:form action="confirmcrtmode">
	<f:input path="internal_training_id" cssStyle="background-color: #D3D3D3" readonly="true"/>
	<f:input path=""/>
	<f:input path=""/>
	<f:button>Save Updates</f:button>
</f:form>

<br>
<br>
</body>
</html>