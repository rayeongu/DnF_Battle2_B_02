<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Dnf.*, java.util.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    캐릭터 player = (캐릭터) session.getAttribute("myPlayer");
    if (player == null) { response.sendRedirect("create.jsp"); return; }

    String action = request.getParameter("action");
    String attackLog = "";
    String itemLog = "";
    
    if ("battle".equals(action)) {
        // 1. 전투 수행 (기존 로직)
        Attack_Monster_UI aUI = new Attack_Monster_UI();
        attackLog = aUI.requestAttack("hero", player);

        // 2. 랜덤 아이템 데이터 생성 (JSP에서 처리)
        Random rd = new Random();
        String[] types = {"무기", "방어구", "물약"};
        String[] names = {"엑스칼리버", "가죽 갑옷", "체력 회복제", "드래곤 슬레이어", "마법 망토", "마나 포션"};
        
        String randomName = names[rd.nextInt(names.length)];
        String randomType = types[rd.nextInt(types.length)];
        int randomValue = rd.nextInt(1500); // 0 ~ 1499 사이의 가치 랜덤 생성

        // 3. 기존 Add_Item_UI의 requestAddItem 메서드 호출
        Add_Item_UI iUI = new Add_Item_UI();
        // pId("hero"), 캐릭터객체, 랜덤이름, 랜덤타입, 랜덤가치를 인자로 전달
        itemLog = iUI.requestAddItem("hero", player, randomName, randomType, randomValue);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>DnF - 전투 및 랜덤 획득</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f8f9fa; }
        .flex-container { display: flex; gap: 20px; max-width: 1000px; margin: auto; }
        .main-panel { flex: 2; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .side-panel { flex: 1; background: #2c3e50; color: white; padding: 20px; border-radius: 12px; }
        .battle-btn { width: 100%; padding: 20px; background: #e74c3c; color: white; border: none; font-size: 1.5rem; font-weight: bold; cursor: pointer; border-radius: 8px; transition: 0.3s; }
        .battle-btn:hover { background: #c0392b; }
        .log-box { background: #f1f3f5; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-left: 5px solid #e74c3c; }
        .inven-item { border-bottom: 1px solid #444; padding: 10px 0; font-size: 0.9rem; }
        .grade-legend { color: #f1c40f; font-weight: bold; } /* 전설: 노란색 */
        .grade-rare { color: #9b59b6; font-weight: bold; }   /* 희귀: 보라색 */
        .grade-common { color: #bdc3c7; }                   /* 일반: 회색 */
        nav { text-align: center; margin-bottom: 30px; }
        nav a { text-decoration: none; color: #3498db; font-weight: bold; margin: 0 15px; }
    </style>
</head>
<body>

<nav>
    <a href="create.jsp">캐릭터 생성</a> | <a href="battle.jsp">사냥터(전투)</a> | <a href="guild.jsp">길드 관리</a>
</nav>

<div class="flex-container">
    <div class="main-panel">
        <h2>⚔️ 아라드 던전</h2>
        
        <div class="log-box">
            <% if(!attackLog.equals("")) { %>
                <div style="margin-bottom: 10px;"><strong>🔥 전투 로그:</strong> <%= attackLog %></div>
                <div style="color: #2980b9;"><strong>🎁 획득 로그:</strong> <%= itemLog %></div>
            <% } else { %>
                <div style="color: #7f8c8d;">몬스터가 나타나기를 기다리고 있습니다...</div>
            <% } %>
        </div>

        <form method="post">
            <button type="submit" name="action" value="battle" class="battle-btn">몬스터 공격!</button>
        </form>
    </div>

    <div class="side-panel">
        <h3>🎒 인벤토리 (<%= player.인벤토리.아이템리스트.size() %>/10)</h3>
        <div class="inven-list">
            <% 
            for(아이템 item : player.인벤토리.아이템리스트) { 
                // 등급명에 따라 CSS 클래스 선택
                String gClass = "grade-common";
                if(item.등급.contains("전설")) gClass = "grade-legend";
                else if(item.등급.contains("희귀")) gClass = "grade-rare";
            %>
                <div class="inven-item">
                    <span class="<%= gClass %>">[<%= item.등급 %>]</span><br>
                    <strong><%= item.아이템명 %></strong> | <%= item.아이템타입 %>
                </div>
            <% } %>
            <% if(player.인벤토리.아이템리스트.isEmpty()) { %>
                <p style="color: #95a5a6;">가방이 비어있습니다.</p>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>