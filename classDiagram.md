```mermaid
classDiagram
    direction TB

    %% Boundary Classes (바운더리 클래스 명시)
    class Create_Character_UI {
        <<boundary>>
        +requestCreate(id, name, job, level) 캐릭터
    }
    class Attack_Monster_UI {
        <<boundary>>
        +requestAttack(id, c) String
    }
    class Add_Item_UI {
        <<boundary>>
        +requestAddItem(pId, c, 명, 타입, 가치) String
    }
    class Join_Guild_UI {
        <<boundary>>
        +requestJoin(id, g, c) String
    }

    %% Control Class (컨트롤 클래스)
       class 플레이어 {
        +플레이어체크(id: String) boolean
    }

    class 캐릭터 {
        <<abstract>>
        +캐릭터명: String
        +레벨: int
        +HP: int
        +공격력: int
        +인벤토리: 인벤토리
        +스킬발동()* String
        +get데미지()* double
    }

    class 전사 {
        +스킬발동() String
        +get데미지() double
    }

    class 마법사 {
        +스킬발동() String
        +get데미지() double
    }

    class 인벤토리 {
        +아이템리스트: List~아이템~
        +최대용량: int
        +아이템추가(item: 아이템) boolean
    }

    class 아이템 {
        +아이템명: String
        +아이템타입: String
        +가치: int
        +등급: String
        -결정등급(가치: int) String
    }

    class 길드 {
        +길드명: String
        +캐릭터리스트: List~캐릭터~
        +최대인원: int
        +캐릭터가입(c: 캐릭터) String
    }

    class 전투 {
        +캐릭터생성(id, 이름, 직업, 레벨) String
        +몬스터공격(id, c) String
    }

    %% --- 관계 설정 ---

    캐릭터 <|-- 전사
    캐릭터 <|-- 마법사
    캐릭터 "1" *-- "1" 인벤토리 : Composition
    인벤토리 "1" *-- "0..10" 아이템 : Composition
    길드 "1" o-- "0..5" 캐릭터 : Aggregation

    %% UI(Boundary) -> Control 호출 관계
    Create_Character_UI ..> 전투 : "request"
    Attack_Monster_UI ..> 전투 : "request"
    Add_Item_UI ..> 전투 : "request"
    Join_Guild_UI ..> 전투 : "request"

    %% Control -> Domain & Player
    전투 ..> 플레이어 : "플레이어체크()"
    전투 ..> 캐릭터 : "데이터 참조"
    전투 ..> 길드 : "가입 처리"
