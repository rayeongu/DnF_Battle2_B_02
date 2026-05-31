package Dnf;

public class Join_Guild_UI {
    // 메서드 이름을 반드시 requestJoin으로 변경
    public String requestJoin(String id, 길드 g, 캐릭터 c) {
        if (!플레이어.플레이어체크(id)) return "길드 가입 실패 (인증 오류)";
        return g.캐릭터가입(c);
    }
}