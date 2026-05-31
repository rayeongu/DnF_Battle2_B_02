<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Dnf.*, java.util.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    캐릭터 player = (캐릭터) session.getAttribute("myPlayer");
    
    // 캐릭터가 생성되지 않았다면 생성 페이지로 이동
    if (player == null) { 
        response.sendRedirect("create.jsp"); 
        return; 
    }

    // 1. 세션에 3개의 길드 초기화 (최초 1회 실행)
    if (session.getAttribute("guildList") == null) {
        List<길드> guilds = new ArrayList<>();
        guilds.add(new 길드("아라드 수호기사단"));
        guilds.add(new 길드("그림자 암살단"));
        guilds.add(new 길드("황실 마법 학회"));
        session.setAttribute("guildList", guilds);
    }
    
    @SuppressWarnings("unchecked")
    List<길드> guildList = (List<길드>) session.getAttribute("guildList");
    String action = request.getParameter("action");
    String gLog = "";

    // 2. 현재 플레이어가 어느 길드에 소속되어 있는지 확인 (중복 가입 방지용)
    길드 myCurrentGuild = null;
    for (길드 g : guildList) {
        if (g.캐릭터리스트.contains(player)) {
            myCurrentGuild = g;
            break;
        }
    }

    // 3. 버튼 액션 처리
    if ("join".equals(action)) {
        int guildIdx = Integer.parseInt(request.getParameter("guildIdx"));
        길드 targetGuild = guildList.get(guildIdx);

        if (myCurrentGuild != null) {
            gLog = "⚠️ 이미 [" + myCurrentGuild.길드명 + "] 소속입니다. 탈퇴 후 가입하세요.";
        } else {
            Join_Guild_UI gUI = new Join_Guild_UI();
            // 기존 UI 클래스의 requestJoin 호출
            gLog = gUI.requestJoin("hero", targetGuild, player);
            
            // 가입 성공 시 상태 업데이트를 위해 페이지 재로딩 유도 가능
            if(gLog.contains("성공")) {
                myCurrentGuild = targetGuild;
            }
        }
    } else if ("leave".equals(action)) {
        if (myCurrentGuild != null) {
            myCurrentGuild.캐릭터리스트.remove(player);
            gLog = "👋 [" + myCurrentGuild.길드명 + "] 길드에서 탈퇴하였습니다.";
            myCurrentGuild = null;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>DnF - 길드 관리소</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f4f7f6; }
        .container { max-width: 800px; margin: auto; }
        .guild-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-top: 20px; }
        .guild-card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; border: 2px solid transparent; }
        .my-guild-card { border-color: #27ae60; background: #ebf9f1; }
        .guild-name { font-size: 1.2rem; font-weight: bold; color: #2c3e50; margin-bottom: 10px; }
        .member-count { color: #7f8c8d; margin-bottom: 15px; }
        .btn { padding: 8px 16px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; width: 100%; }
        .btn-join { background-color: #3498db; color: white; }
        .btn-leave { background-color: #e74c3c; color: white; }
        .log-msg { background: #34495e; color: #ecf0f1; padding: 10px; border-radius: 5px; text-align: center; margin-bottom: 20px; }
        nav { text-align: center; margin-bottom: 30px; }
        nav a { text-decoration: none; color: #3498db; font-weight: bold; margin: 0 15px; }
    </style>
</head>
<body>

<nav>
    <a href="create.jsp">캐릭터 정보</a> | <a href="battle.jsp">사냥터(전투)</a> | <a href="guild.jsp">길드 관리</a>
</nav>

<div class="container">
    <h2 style="text-align: center;">🏰 아라드 길드 연합</h2>
    
    <% if (!gLog.equals("")) { %>
        <div class="log-msg"><%= gLog %></div>
    <% } %>

    <div class="guild-grid">
        <% 
        for (int i = 0; i < guildList.size(); i++) { 
            길드 g = guildList.get(i);
            boolean isMember = (myCurrentGuild != null && myCurrentGuild.equals(g));
        %>
            <div class="guild-card <%= isMember ? "my-guild-card" : "" %>">
                <div class="guild-name"><%= g.길드명 %></div>
                <div class="member-count">인원: <%= g.캐릭터리스트.size() %> / 5</div>
                
                <form method="post">
                    <input type="hidden" name="guildIdx" value="<%= i %>">
                    <% if (isMember) { %>
                        <button type="submit" name="action" value="leave" class="btn btn-leave">길드 탈퇴</button>
                    <% } else { %>
                        <button type="submit" name="action" value="join" class="btn btn-join" <%= (myCurrentGuild != null) ? "disabled" : "" %>>
                            <%= (myCurrentGuild != null) ? "소속 있음" : "가입하기" %>
                        </button>
                    <% } %>
                </form>

                <div style="margin-top: 15px; text-align: left; font-size: 0.85rem;">
                    <strong>[길드원 명단]</strong><br>
                    <% for (Object obj : g.캐릭터리스트) { 
                        캐릭터 m = (캐릭터) obj; %>
                        • <%= m.캐릭터명 %> (Lv.<%= m.레벨 %>)<br>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>
</div>

</body>
</html>