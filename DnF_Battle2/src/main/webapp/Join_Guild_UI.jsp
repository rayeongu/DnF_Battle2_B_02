<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dnf2.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String 플레이어id = request.getParameter("playerId");
    String 입력길드명 = request.getParameter("guildName");

    // 길드는 이미 다른 곳에서 만들어진 객체임을 시뮬레이션 [cite: 15]
    길드 guild = (길드) session.getAttribute("globalGuild");
    if (guild == null) {
        guild = new 길드("아라드수호대"); // 테스트용 기본 길드 생성
        session.setAttribute("globalGuild", guild);
    }

    캐릭터 character = (캐릭터) session.getAttribute("myDnFCharacter");
    boolean isSubmitted = (플레이어id != null && 입력길드명 != null);
    String 결과메시지 = "";

    if (isSubmitted) {
        전투 battle = new 전투();
        // 입력한 길드명이 세션에 있는 길드명과 같을 때만 가입 로직 수행
        if(입력길드명.equals(guild.get길드명())) {
            결과메시지 = battle.길드가입(플레이어id, guild, character);
        } else {
            결과메시지 = "서버에 해당 이름의 길드가 존재하지 않습니다.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>DnF Battle - 길드 가입</title>
    <style>
        body { font-family: 'Consolas', monospace; background-color: #0d1117; color: #c9d1d9; padding: 30px; }
        .box { background-color: #161b22; border: 1px solid #30363d; padding: 20px; max-width: 500px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 100px; font-weight: bold; }
        input { background-color: #0d1117; color: #c9d1d9; border: 1px solid #30363d; padding: 5px; }
        .btn { background-color: #238636; color: white; border: none; padding: 8px 16px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="box">
        <h3>🛡️ 길드 가입</h3>
        <p style="color: #8b949e; font-size: 0.9em;">(현재 서버에 존재하는 길드: <%= guild.get길드명() %>)</p>
        <form method="POST">
            <div class="form-group">
                <label>플레이어 ID</label><input type="text" name="playerId" value="hero" required>
            </div>
            <div class="form-group">
                <label>길드명</label><input type="text" name="guildName" required>
            </div>
            <button type="submit" class="btn">길드 가입 신청</button>
        </form>
    </div>
    <% if (isSubmitted) { %>
        <div class="box">
            <p>> <%= 결과메시지 %></p>
            <p style="color: #8b949e; font-size: 0.9em;">(현재 길드 인원: <%= guild.get현재인원() %> / 5 명)</p>
        </div>
    <% } %>
</body>
</html>