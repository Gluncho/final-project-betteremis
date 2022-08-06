<%@ page import="DAO.Interfaces.SubjectHistoryDAO" %>
<%@ page import="DAO.Mapping" %>
<%@ page import="DAO.Interfaces.*" %>
<%@ page import="Model.Student" %>
<%@ page import="Model.Subject" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: dito
  Date: 06.08.22
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String subName = (String) request.getSession().getAttribute("subjectName");
    String email = (String) request.getSession().getAttribute("studentEmail");
    SubjectHistoryDAO subDao = (SubjectHistoryDAO) application.getAttribute(Mapping.SUBJECT_HISTORY_DAO);
    StudentDAO studentDAO = (StudentDAO) application.getAttribute(Mapping.STUDENT_DAO);
    SubjectDAO subjectDAO = (SubjectDAO) application.getAttribute(Mapping.SUBJECT_DAO);
    Student student = studentDAO.getStudentWithEmail(email);
    Subject subject = subjectDAO.getSubjectByName(subName);
    Map<String, Double> grades = subDao.getGrade(student,subject);

%>

<%!
    private String decorate(String name, double value){
        String res = " <div><label for=\"" + name + "\">" + name + "</label></div>\n" +
                "<input name=\"" + name + "\" placeholder=\"Enter -1 to discard this field\" type=\"number\" value =\"" + value+"\"  step=\"any\" min=\"-1\" max=\"100\">";
        return res;
    }
%>

<script>
    function removeField(fieldName) {
        var elem = document.querySelector('#'+ fieldName);
        elem.parentNode.removeChild(elem);
    }
</script>

<html>
<head>
    <title>Title</title>
</head>
<body>
    <div class = "mainPanel">
        <form class="markform" action="../ServletChangeMarks" method="POST">
            <%
                for(String name : grades.keySet()){
                    if(grades.get(name)!=-1){
                        out.println(decorate(name, grades.get(name)));
                    }
                }
            %>
            <input type="hidden" name= "subname" value= <%= subName %> > >
            <input type="hidden" name= "email" value= <%= email %> > >
            <input type="submit" value="Submit scores">
        </form>

        <form class="resetForm" action="../ServletChangeMarks" method="POST" >
            <input type="hidden" name= "subname" value= <%= subName %> > >
            <input type="hidden" name= "email" value= <%= email %> > >
            <input type = "hidden" name = "reset" value="Reset">
            <input type = "submit" value="Reset Default">
        </form>
    </div>
</body>
</html>
