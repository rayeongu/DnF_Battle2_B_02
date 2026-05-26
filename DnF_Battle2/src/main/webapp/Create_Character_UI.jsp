<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dnf2.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String 플레이어id = request.getParameter("playerId");
    String 캐릭터명 = request.getParameter("charName");
    String 직업 = request.getParameter("job");
    String levelStr = request.getParameter("level");

    캐릭터 character = null;
    boolean isSubmitted = (플레이어id != null && !플레이어id.isEmpty());

    if (isSubmitted) {
        int 레벨 = 1;
        if (levelStr != null && !levelStr.isEmpty()) {
            레벨 = Integer.parseInt(levelStr);
        }

        전투 battle = new 전투();
        character = battle.캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨);

        if (character != null) {
            session.setAttribute("myDnFCharacter", character);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>DnF Battle - 캐릭터 생성</title>
    <style>
        body { font-family: 'Consolas', monospace; background-color: #0d1117; color: #c9d1d9; padding: 30px; }
        .box { background-color: #161b22; border: 1px solid #30363d; padding: 20px; border-radius: 6px; max-width: 500px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 100px; font-weight: bold; color: #8b949e; }
        input[type="text"], input[type="number"] { background-color: #0d1117; color: #c9d1d9; border: 1px solid #30363d; padding: 5px 10px; border-radius: 4px; width: 200px; }
        input[type="text"]:focus, input[type="number"]:focus { border-color: #58a6ff; outline: none; }
        .toggle-group label { width: auto; margin-right: 15px; cursor: pointer; color: #c9d1d9; }
        .btn { background-color: #238636; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: 'Consolas', monospace; }
        .btn:hover { background-color: #2ea043; }
        a.btn-link { color: #58a6ff; text-decoration: none; font-weight: bold; display: inline-block; margin-top: 10px; }
        a.btn-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="box">
        <h3 style="margin-top: 0;">⚔️ 캐릭터 생성</h3>
        <form method="POST" action="Create_Character_UI.jsp">
            <div class="form-group">
                <label>플레이어 ID</label>
                <input type="text" name="playerId" value="hero" required> 
            </div>
            <div class="form-group">
                <label>캐릭터명</label>
                <input type="text" name="charName" placeholder="예: 귀검사" required>
            </div>
            <div class="form-group">
                <label>직업 선택</label>
                <span class="toggle-group">
                    <label><input type="radio" name="job" value="전사" checked> 전사</label>
                    <label><input type="radio" name="job" value="마법사"> 마법사</label>
                </span>
            </div>
            <div class="form-group">
                <label>레벨</label>
                <input type="number" name="level" value="10" min="1" required>
            </div>
            <button type="submit" class="btn">캐릭터 생성</button>
        </form>
    </div>

    <% if (isSubmitted) { %>
        <div class="box">
            <h3 style="margin-top: 0; color: #58a6ff;">[캐릭터 생성 정보]</h3>
            <p>> 플레이어 ID : <%= 플레이어id %></p>
            <p>> 캐릭터명 : <%= 캐릭터명 %></p>
            <p>> 직업 : <%= 직업 %></p>
            <p>> 레벨 : <%= levelStr %> Lv</p>
            
            <% if (character != null) { %>
                <p style="color: #3fb950; font-size: 1.1em; margin-top: 15px;"><strong>▶ 플레이어 생성 완료</strong></p>
                <hr style="border: 0; border-top: 1px solid #30363d; margin: 15px 0;">
                
                <h4>[생성된 캐릭터 상세 능력치]</h4>
                <p>- 기본 HP : <%= character.getHP() %></p>
                <p>- 기본 공격력 : <%= character.get공격력() %></p>
                
                <a href="Attack_Monster_UI.jsp" class="btn-link">> [전투 시뮬레이션 이동] 몬스터 공격하기</a><br>
				<a href="Add_Item_UI.jsp" class="btn-link">> [아이템 시스템 이동] 아이템 획득하기</a><br>
				<a href="Join_Guild_UI.jsp" class="btn-link">> [길드 시스템 이동] 길드 가입하기</a>
            <% } else { %>
                <hr style="border: 0; border-top: 1px solid #30363d; margin: 15px 0;">
                <p style="color: #f85149;"><strong>▶ 플레이어 생성 실패 (플레이어 ID가 'hero'인지 확인하세요)</strong></p>
            <% } %>
        </div>
    <% } %>
</body>
</html>