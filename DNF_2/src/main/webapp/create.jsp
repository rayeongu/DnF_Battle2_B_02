<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Dnf.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    캐릭터 player = (캐릭터) session.getAttribute("myPlayer");
    String action = request.getParameter("action");

    if ("create".equals(action)) {
        Create_Character_UI cUI = new Create_Character_UI();
        player = cUI.requestCreate(request.getParameter("pId"), request.getParameter("cName"), 
                                 request.getParameter("job"), Integer.parseInt(request.getParameter("level")));
        session.setAttribute("myPlayer", player);
    } else if ("reset".equals(action)) {
        session.invalidate();
        response.sendRedirect("create.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>DnF - Character</title>
    <style>
        body { font-family: sans-serif; padding: 20px; background: #f4f4f4; }
        .card { background: white; padding: 20px; border-radius: 10px; max-width: 500px; margin: auto; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        nav { text-align: center; margin-bottom: 20px; }
        nav a { margin: 0 10px; text-decoration: none; color: #007bff; font-weight: bold; }
    </style>
</head>
<body>
    <nav>
        <a href="create.jsp">내 정보</a> | <a href="battle.jsp">던전(전투/인벤)</a> | <a href="guild.jsp">길드회관</a>
    </nav>

    <div class="card">
        <% if (player == null) { %>
            <h2>🆕 캐릭터 생성</h2>
            <form method="post">
                <input type="hidden" name="action" value="create">
                ID: <input type="text" name="pId" value="hero" readonly><br><br>
                이름: <input type="text" name="cName" required><br><br>
                직업: <select name="job"><option>전사</option><option>마법사</option></select><br><br>
                레벨: <input type="number" name="level" value="1" min="1"><br><br>
                <button type="submit" style="width:100%">생성하기</button>
            </form>
        <% } else { %>
            <h2>👤 캐릭터 상태창</h2>
            <p><strong>이름:</strong> <%= player.캐릭터명 %></p>
            <p><strong>레벨:</strong> <%= player.레벨 %></p>
            <p><strong>HP:</strong> <%= player.HP %></p>
            <p><strong>공격력:</strong> <%= player.공격력 %></p>
            <hr>
            <a href="create.jsp?action=reset" style="color:red;">캐릭터 삭제(초기화)</a>
        <% } %>
    </div>
</body>
</html>