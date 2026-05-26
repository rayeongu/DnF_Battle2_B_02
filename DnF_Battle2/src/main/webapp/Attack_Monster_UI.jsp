<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dnf2.*" %>
<%
    String 플레이어id = "hero";
    캐릭터 character = (캐릭터) session.getAttribute("myDnFCharacter");

    전투 battle = new 전투();
    String 전투결과 = battle.몬스터공격(플레이어id, character);
%>
<!DOCTYPE html>
<html>
<head>
    <title>DnF Battle - 전투</title>
    <style>
        body { font-family: 'Consolas', monospace; background-color: #0d1117; color: #c9d1d9; padding: 30px; }
        .box { background-color: #161b22; border: 1px solid #30363d; padding: 20px; max-width: 500px; }
    </style>
</head>
<body>
    <div class="box">
        <h3>[시스템] 전투 결과</h3>
        <p>> <%= 전투결과 %></p>
    </div>
</body>
</html>