package dnf2;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
	private String 길드명;
	private List<캐릭터> 캐릭터리스트;
	private int 최대인원 = 5;

	public 길드(String 길드명) {
		this.길드명 = 길드명;
		this.캐릭터리스트 = new ArrayList<>();
	}

	public String 캐릭터가입(캐릭터 character) {
		if (캐릭터리스트.size() < 최대인원) {
			캐릭터리스트.add(character);
			return character.get캐릭터명() + "님이 [" + 길드명 + "] 길드에 가입되었습니다!";
		}
		return "길드 정원이 가득 차 가입할 수 없습니다.";
	}

	public String get길드명() {
		return 길드명;
	}

	public int get현재인원() {
		return 캐릭터리스트.size();
	}
}