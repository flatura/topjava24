<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="ru">
<head>
    <title>Meals</title>
</head>
<body>
<h3><a href="index.html">Home</a></h3>
<hr>
<h2>Meals</h2>
<table class="table table-hover table-sm">
    <thead>
    <tr>
        <th scope="col">Date and time</th>
        <th scope="col">Description</th>
        <th scope="col">Calories</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="meal" items="${list}">
        <tr>
            <td>${meal.getDateTime()}</td>
            <td>${meal.getDescription()}</td>
            <th style="${meal.isExcess() ? 'color: #ff0000' : 'color: #00ff00'}">${meal.getCalories()}</th>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>