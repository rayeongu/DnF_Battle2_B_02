package Dnf;

public class Add_Item_UI {
    public String requestAddItem(String pId, 캐릭터 c, String 명, String 타입, int 가치) {
        // 요구사항: 반드시 플레이어 체크를 한다
        if (!"hero".equals(pId)) {
            return "플레이어 인증 실패!";
        }

        아이템 newItem = new 아이템(명, 타입, 가치);
        boolean 결과 = c.인벤토리.아이템추가(newItem);

        if (결과) {
            return "[" + newItem.등급 + "] " + 명 + "(" + 타입 + ") 획득 성공!";
        } else {
            return "인벤토리가 가득 차서 아이템을 획득할 수 없습니다! (최대 10개)";
        }
    }
}