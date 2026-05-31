package Dnf;

public class 전사 extends 캐릭터 {
    public 전사(String 캐릭터명, int 레벨) {
        super(캐릭터명, 레벨);
        this.HP = 레벨 * 100;
        this.공격력 = 레벨 * 15;
    }
    @Override
    public String 스킬발동() { return "검 휘두르기!"; }
    @Override
    public double get데미지() { return 공격력 * 1.5; }
}