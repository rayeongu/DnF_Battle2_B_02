package Dnf;

public class 전투 {
    public static String 캐릭터생성(String id, String 이름, String 직업, int 레벨) {
        if (!플레이어.플레이어체크(id)) return "ID 불일치: 접근 권한이 없습니다.";
        캐릭터 newChar = 직업.equals("전사") ? new 전사(이름, 레벨) : new 마법사(이름, 레벨);
        return 이름 + "(" + 직업 + ") 캐릭터가 생성되었습니다. (HP: " + newChar.HP + ")";
    }

    public static String 몬스터공격(String id, 캐릭터 c) {
        if (!플레이어.플레이어체크(id)) return "권한 없음";
        double damage = c.get데미지();
        String grade = damage >= 200 ? "S급" : (damage >= 100 ? "A급" : "B급");
        return c.스킬발동() + " 데미지: " + damage + " [" + grade + " 공격]";
    }
}