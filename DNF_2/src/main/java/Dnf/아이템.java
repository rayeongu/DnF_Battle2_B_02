package Dnf;

public class 아이템 {
    public String 아이템명;
    public String 아이템타입; // 무기, 방어구, 물약
    public int 가치;
    public String 등급;

    public 아이템(String 명, String 타입, int 가치) {
        this.아이템명 = 명;
        this.아이템타입 = 타입;
        this.가치 = 가치;
        
        // 요구사항: 가치에 따른 등급 부여
        if (가치 >= 1000) this.등급 = "전설(Legendary)";
        else if (가치 >= 500) this.등급 = "희귀(Rare)";
        else this.등급 = "일반(Common)";
    }
}