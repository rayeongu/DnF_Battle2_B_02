package Dnf;

public class Create_Character_UI {
    // 메서드 이름을 반드시 requestCreate로 변경
    public 캐릭터 requestCreate(String id, String name, String job, int level) {
        if (!플레이어.플레이어체크(id)) return null;
        if (job.equals("전사")) return new 전사(name, level);
        else return new 마법사(name, level);
    }
}