package Dnf;

public abstract class 캐릭터 {
    // 모든 필드 앞에 'public'을 붙여야 JSP에서 가져다 쓸 수 있습니다.
    public String 캐릭터명; 
    public int 레벨;      
    public int HP;        
    public int 공격력;     
    
    // Composition 관계인 인벤토리도 public이어야 합니다.
    public 인벤토리 인벤토리 = new 인벤토리(); 

    public 캐릭터(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
    }
    
    public abstract String 스킬발동();
    public abstract double get데미지();
}