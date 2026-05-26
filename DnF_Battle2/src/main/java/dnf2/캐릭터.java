package dnf2;

public abstract class 캐릭터 {
	protected String 캐릭터명;
	protected int 레벨;
	protected int HP;
	protected int 공격력;

	public abstract int 스킬발동();

	public abstract String get스킬명();

	public String get캐릭터명() {
		return 캐릭터명;
	}

	public int get레벨() {
		return 레벨;
	}

	public int getHP() {
		return HP;
	}

	public int get공격력() {
		return 공격력;
	}
}