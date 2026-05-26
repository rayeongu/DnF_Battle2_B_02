```mermaid
classDiagram
    class 캐릭터 {
        <<abstract>>
        #캐릭터명 : String
        #레벨 : int
        #HP : int
        #공격력 : int
        +스킬발동()* int
        +get스킬명()* String
        +get캐릭터명() String
        +get레벨() int
        +getHP() int
        +get공격력() int
    }

    class 전사 {
        +전사(캐릭터명: String, 레벨: int)
        +스킬발동() int
        +get스킬명() String
    }

    class 마법사 {
        +마법사(캐릭터명: String, 레벨: int)
        +스킬발동() int
        +get스킬명() String
    }

    class 플레이어 {
        +플레이어체크(플레이어id: String) boolean
    }

    class 전투 {
        +캐릭터생성(플레이어id: String, 캐릭터명: String, 직업: String, 레벨: int) 캐릭터
        +몬스터공격(플레이어id: String, character: 캐릭터) String
    }

    class 아이템 {
        -아이템명 : String
        -타입 : String
        -가치 : int
        -등급 : String
    }

    class 인벤토리 {
        -아이템리스트 : List
        -최대용량 : int
        +아이템추가(item: 아이템) boolean
    }

    class 길드 {
        -길드명 : String
        -캐릭터리스트 : List
        -최대인원 : int
        +캐릭터가입(character: 캐릭터) boolean
    }

    %% 관계 정의
    전사 --|> 캐릭터 : 상속
    마법사 --|> 캐릭터 : 상속

    전투 ..> 플레이어 : 의존
    전투 ..> 캐릭터 : 의존
    전투 ..> 전사 : 의존
    전투 ..> 마법사 : 의존

    캐릭터 "1" *-- "1" 인벤토리 : 합성 (Composition)
    인벤토리 "1" *-- "0..*" 아이템 : 합성 (Composition)
    길드 "1" o-- "0..*" 캐릭터 : 집약 (Aggregation)