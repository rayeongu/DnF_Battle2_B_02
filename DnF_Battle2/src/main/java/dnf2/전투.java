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

	public String 아이템획득(String 플레이어id, 캐릭터 character, String 아이템명, String 타입, int 가치) {
		플레이어 player = new 플레이어();

		if (!player.플레이어체크(플레이어id))
			return "플레이어 권한이 없습니다.";
		if (character == null)
			return "생성된 캐릭터가 없습니다.";

		아이템 newItem = new 아이템(아이템명, 타입, 가치);
		boolean isAdded = character.get인벤토리().아이템추가(newItem);

		if (isAdded) {
			return 아이템명 + " [" + 타입 + "] (" + newItem.get등급() + ") 획득! 인벤토리에 추가되었습니다.";
		} else {
			return "인벤토리가 가득 차(10개) 아이템을 획득할 수 없습니다.";
		}
	}

	public String 길드가입(String 플레이어id, 길드 guild, 캐릭터 character) {
		플레이어 player = new 플레이어();

		if (!player.플레이어체크(플레이어id))
			return "플레이어 권한이 없습니다.";
		if (character == null)
			return "생성된 캐릭터가 없습니다.";
		if (guild == null)
			return "존재하지 않는 길드입니다.";

		return guild.캐릭터가입(character);
	}
}