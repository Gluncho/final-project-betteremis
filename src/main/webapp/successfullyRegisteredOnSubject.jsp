<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 7/30/2022
  Time: 8:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta chartset="utf-8">
    <title>Successfully registered!</title>
    <link rel="stylesheet" href="css/welcome.scss">
</head>
<body>

    <div class="container">
        <span class="text1">Successfully registered on <%= request.getParameter("currentSubject")%></span>
        <span class="text2"><a href="studentPages/studentProfile.jsp">Go to profile</a></span>
    </div>

</body>
</html>
