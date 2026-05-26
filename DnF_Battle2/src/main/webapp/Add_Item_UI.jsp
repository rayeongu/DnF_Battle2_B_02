<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dnf2.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String 플레이어id = request.getParameter("playerId");
    String 아이템명 = request.getParameter("itemName");
    String 타입 = request.getParameter("itemType");
    String 가치Str = request.getParameter("itemValue");

    캐릭터 character = (캐릭터) session.getAttribute("myDnFCharacter");
    boolean isSubmitted = (플레이어id != null && 아이템명 != null);
    String 결과메시지 = "";

    if (isSubmitted) {
        int 가치 = Integer.parseInt(가치Str);
        전투 battle = new 전투();
        결과메시지 = battle.아이템획득(플레이어id, character, 아이템명, 타입, 가치);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>DnF Battle - 아이템 획득</title>
    <style>
        body { font-family: 'Consolas', monospace; background-color: #0d1117; color: #c9d1d9; padding: 30px; }
        .box { background-color: #161b22; border: 1px solid #30363d; padding: 20px; max-width: 500px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 100px; font-weight: bold; }
        input, select { background-color: #0d1117; color: #c9d1d9; border: 1px solid #30363d; padding: 5px; }
        .btn { background-color: #238636; color: white; border: none; padding: 8px 16px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="box">
        <h3>🎒 아이템 획득</h3>
        <form method="POST">
            <div class="form-group">
                <label>플레이어 ID</label><input type="text" name="playerId" value="hero" required>
            </div>
            <div class="form-group">
                <label>아이템명</label><input type="text" name="itemName" required>
            </div>
            <div class="form-group">
                <label>아이템 타입</label>
                <select name="itemType">
                    <option value="무기">무기</option>
                    <option value="방어구">방어구</option>
                    <option value="물약">물약</option>
                </select>
            </div>
            <div class="form-group">
                <label>아이템 가치</label><input type="number" name="itemValue" required>
            </div>
            <button type="submit" class="btn">아이템 획득하기</button>
        </form>
    </div>
    <% if (isSubmitted) { %>
        <div class="box">
            <p>> <%= 결과메시지 %></p>
        </div>
    <% } %>
</body>
</html>