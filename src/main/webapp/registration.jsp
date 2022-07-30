<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DAO.Interfaces.SubjectDAO" %>
<%@ page import="DAO.Mapping" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.Interfaces.LecturerDAO" %>
<%@ page import="Model.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="DAO.Interfaces.UserDAO" %>
<%
  SubjectDAO subjectDAO = (SubjectDAO) application.getAttribute(Mapping.SUBJECT_DAO);
  LecturerDAO lecDAO = (LecturerDAO) application.getAttribute(Mapping.LECTURER_DAO);
  UserDAO userDAO = (UserDAO) application.getAttribute(Mapping.USER_DAO);
  User user1 = new User("dshis20@freeuni.edu.ge", "bla" , USERTYPE.LECTURER);
  int ID = userDAO.addUser(user1);
  Lecturer lecturer1 = new Lecturer(user1.getEmail(),user1.getPasswordHash(),user1.getType(),ID,"dimitri","shishniashvili",
          "developer", GENDER.MALE, Date.valueOf("2002-02-12"),"tbilisi",STATUS.ACTIVE,new BigInteger("599"));
  ID = lecDAO.addLecturer(lecturer1);

  Subject subject1 = new Subject("Computer Science 1", 6, ID);
  subjectDAO.addSubject(subject1);

  Subject subject2 = new Subject("Computer Science 2", 6, ID);
  subjectDAO.addSubject(subject2);

  Subject subject3 = new Subject("Computer Science 3", 6, ID);
  subjectDAO.addSubject(subject2);

  List<Subject> allSubjects = subjectDAO.getAllSubjects();
%>

<%!
  public String decorate(Subject subject, LecturerDAO lecDAO){
    Lecturer lec = lecDAO.getLecturerWithID(subject.getLecturerID());
    return  "<tr>\n" +
            "        <td>" + subject.getName() + "</td>\n" +
            "        <td> " + lec.getFirstName() + " " + lec.getLastName() + "</td>\n" +
            "        <td> " + subject.getNumCredits() + "</td>\n" +
            "        <td>Syllabus is currently unavailable</td>\n" +
            "        <td>" +
            "           <form action = \"SubjectRegistrationServlet\" method = \"POST\">" +
            "             <input type = \"hidden\" name = \"currentSubject\" value = \""+ subject.getName() + "\"/>" +
            "             <input type = \"submit\" value = \"Register\"/>" +
            "           </form></td>\n" +
            "</tr>\n";
  }
%>

<html>
<head>
  <title>Registration</title>
  <link rel="stylesheet" href="css/registrationStyle.scss">
</head>
<body>

<table>
<%
  out.println("<tr >\n" +
              "   <th><h1>Subject Name</h1></th>\n" +
              "   <th><h1>Lecturer</h1></th>\n" +
              "   <th><h1>Credits</h1></th>\n" +
              "   <th><h1>Syllabus</h1></th>\n" +
              "</tr>\n");
  for(Subject subject : allSubjects){
    out.println(decorate(subject, lecDAO));
  }
%>
</table>

</body>

</html>


































<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Registration</title>--%>
<%--  <link rel="stylesheet" href="<%=request.getContextPath()%>/registrationStyle.scss">--%>
<%--  <script>--%>
<%--    var Pagination = {--%>
<%--      code: '',--%>
<%--      Extend: function(data) {--%>
<%--        data = data || {};--%>
<%--        Pagination.size = data.size || 300;--%>
<%--        Pagination.page = data.page || 1;--%>
<%--        Pagination.step = data.step || 3;--%>
<%--      },--%>
<%--      Add: function(s, f) {--%>
<%--        for (var i = s; i < f; i++) {--%>
<%--          Pagination.code += '<a>' + i + '</a>';--%>
<%--        }--%>
<%--      },--%>
<%--      Last: function() {--%>
<%--        Pagination.code += '<i>...</i><a>' + Pagination.size + '</a>';--%>
<%--      },--%>

<%--      First: function() {--%>
<%--        Pagination.code += '<a>1</a><i>...</i>';--%>
<%--      },--%>
<%--      Click: function() {--%>
<%--        Pagination.page = +this.innerHTML;--%>
<%--        Pagination.Start();--%>
<%--      },--%>
<%--      Prev: function() {--%>
<%--        Pagination.page--;--%>
<%--        if (Pagination.page < 1) {--%>
<%--          Pagination.page = 1;--%>
<%--        }--%>
<%--        Pagination.Start();--%>
<%--      },--%>
<%--      Next: function() {--%>
<%--        Pagination.page++;--%>
<%--        if (Pagination.page > Pagination.size) {--%>
<%--          Pagination.page = Pagination.size;--%>
<%--        }--%>
<%--        Pagination.Start();--%>
<%--      },--%>
<%--      Bind: function() {--%>
<%--        var a = Pagination.e.getElementsByTagName('a');--%>
<%--        for (var i = 0; i < a.length; i++) {--%>
<%--          if (+a[i].innerHTML === Pagination.page) a[i].className = 'current';--%>
<%--          a[i].addEventListener('click', Pagination.Click, false);--%>
<%--        }--%>
<%--      },--%>
<%--      Finish: function() {--%>
<%--        Pagination.e.innerHTML = Pagination.code;--%>
<%--        Pagination.code = '';--%>
<%--        Pagination.Bind();--%>
<%--      },--%>
<%--      Start: function() {--%>
<%--        if (Pagination.size < Pagination.step * 2 + 6) {--%>
<%--          Pagination.Add(1, Pagination.size + 1);--%>
<%--        }--%>
<%--        else if (Pagination.page < Pagination.step * 2 + 1) {--%>
<%--          Pagination.Add(1, Pagination.step * 2 + 4);--%>
<%--          Pagination.Last();--%>
<%--        }--%>
<%--        else if (Pagination.page > Pagination.size - Pagination.step * 2) {--%>
<%--          Pagination.First();--%>
<%--          Pagination.Add(Pagination.size - Pagination.step * 2 - 2, Pagination.size + 1);--%>
<%--        }--%>
<%--        else {--%>
<%--          Pagination.First();--%>
<%--          Pagination.Add(Pagination.page - Pagination.step, Pagination.page + Pagination.step + 1);--%>
<%--          Pagination.Last();--%>
<%--        }--%>
<%--        Pagination.Finish();--%>
<%--      },--%>
<%--      Buttons: function(e) {--%>
<%--        var nav = e.getElementsByTagName('a');--%>
<%--        nav[0].addEventListener('click', Pagination.Prev, false);--%>
<%--        nav[1].addEventListener('click', Pagination.Next, false);--%>
<%--      },--%>
<%--      Create: function(e) {--%>

<%--        var html = [--%>
<%--          '<a>&#9668;</a>',--%>
<%--          '<span></span>',--%>
<%--          '<a>&#9658;</a>'--%>
<%--        ];--%>

<%--        e.innerHTML = html.join('');--%>
<%--        Pagination.e = e.getElementsByTagName('span')[0];--%>
<%--        Pagination.Buttons(e);--%>
<%--      },--%>
<%--      Init: function(e, data) {--%>
<%--        Pagination.Extend(data);--%>
<%--        Pagination.Create(e);--%>
<%--        Pagination.Start();--%>
<%--      }--%>
<%--    };--%>
<%--    var init = function() {--%>
<%--      Pagination.Init(document.getElementById('pagination'), {--%>
<%--        size: 30,--%>
<%--        page: 1,--%>
<%--        step: 3--%>
<%--      });--%>
<%--    };--%>
<%--    document.addEventListener('DOMContentLoaded', init, false);--%>
<%--  </script>--%>
<%--</head>--%>
<%--<body>--%>

<%--<div class = "sMenu">--%>
<%--  <ul class="nav">--%>
<%--    <li id="settings">--%>
<%--      <a href="#"><img src="https://designmodo.com/demo/dropdown-menu-search/settings.png" /></a>--%>
<%--    </li>--%>
<%--    <li>--%>
<%--      <a href="#">Subjects</a>--%>
<%--    </li>--%>
<%--    <li>--%>
<%--      <a href="#">Board</a>--%>
<%--    </li>--%>
<%--    <li id="search">--%>
<%--      <form action="" method="get">--%>
<%--        <input type="text" name="search_text" id="search_text" placeholder="Search"/>--%>
<%--        <input type="button" name="search_button" id="search_button"></a>--%>
<%--      </form>--%>
<%--    </li>--%>
<%--    <li id="options">--%>
<%--      <a href="#">Options</a>--%>
<%--      <ul class="subnav">--%>
<%--        <li><a href="#">Settings</a></li>--%>
<%--        <li><a href="#">Application</a></li>--%>
<%--        <li><a href="#">Board</a></li>--%>
<%--        <li><a href="#">Options</a></li>--%>
<%--      </ul>--%>
<%--    </li>--%>
<%--  </ul>--%>
<%--</div>--%>
<%--<script src="prefixfree-1.0.7.js" type="text/javascript"></script>--%>
<%--<div id="footer">--%>
<%--  <div id="pagination"></div>--%>
<%--</div>--%>

<%--</body>--%>

<%--</html>--%>



