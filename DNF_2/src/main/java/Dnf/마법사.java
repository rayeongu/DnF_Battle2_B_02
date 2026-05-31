package Dnf;

public class 마법사 extends 캐릭터 {
    public 마법사(String 캐릭터명, int 레벨) {
        super(캐릭터명, 레벨);
        this.HP = 레벨 * 60;
        this.공격력 = 레벨 * 25;
    }
    @Override
    public String 스킬발동() { return "파이어볼!"; }
    @Override
    public double get데미지() { return 공격력 * 2.0; }
}