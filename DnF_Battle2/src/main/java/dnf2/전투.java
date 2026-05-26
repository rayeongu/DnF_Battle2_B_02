package dnf2;

public class 전투 {
	public 캐릭터 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
		플레이어 player = new 플레이어();

		if (player.플레이어체크(플레이어id)) {
			if ("전사".equals(직업)) {
				return new 전사(캐릭터명, 레벨);
			} else if ("마법사".equals(직업)) {
				return new 마법사(캐릭터명, 레벨);
			}
		}
		return null;
	}

	public String 몬스터공격(String 플레이어id, 캐릭터 character) {
		플레이어 player = new 플레이어();

		if (player.플레이어체크(플레이어id)) {
			if (character == null)
				return "생성된 캐릭터가 없습니다.";

			int 데미지 = character.스킬발동();
			String 등급 = "";

			if (데미지 >= 200) {
				등급 = "S급 공격";
			} else if (데미지 >= 100) {
				등급 = "A급 공격";
			} else {
				등급 = "B급 공격";
			}

			return character.get캐릭터명() + "의 [" + character.get스킬명() + "] 몬스터에게 " + 데미지 + "의 데미지를 입혔습니다! (" + 등급 + ")";
		}
		return "플레이어 권한이 없습니다.";
	}
}