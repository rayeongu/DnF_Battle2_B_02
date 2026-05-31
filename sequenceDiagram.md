```mermaid
sequenceDiagram
    autonumber
    actor Player as 플레이어 (브라우저)
    participant UI_Create as Create_Character_UI.jsp
    participant UI_Attack as Attack_Monster_UI.jsp
    participant UI_Item as Add_Item_UI.jsp
    participant UI_Guild as Join_Guild_UI.jsp
    participant Session as Session (세션)
    participant Battle as 전투 (Class)
    participant Model as 캐릭터/전사/마법사 (Class)
    participant Inventory as 인벤토리 (Class)
    participant Item as 아이템 (Class)
    participant Guild as 길드 (Class)

    Player->>UI_Create: 캐릭터 생성 요청 (ID, 이름, 직업, 레벨)
    activate UI_Create
    UI_Create->>Battle: 캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨)
    activate Battle
    Note over Battle: 플레이어 ID가 "hero"인지 체크
    alt 플레이어 인증 성공 ("hero")
        Note over Model: 인스턴스 생성 (new 전사 / 마법사)
        Battle->>Model: 캐릭터 객체 초기화
        activate Model
        Note over Inventory: 인스턴스 생성 (new 인벤토리)
        Model->>Inventory: 인벤토리 생성 및 할당
        Model-->>Battle: 생성된 캐릭터 객체 반환
        Battle-->>UI_Create: 캐릭터 객체 반환
        deactivate Battle
        UI_Create->>Session: setAttribute("myDnFCharacter", character)
        UI_Create-->>Player: 캐릭터 생성 완료 화면 및 스탯 표시
    else 플레이어 인증 실패
        Battle-->>UI_Create: null 반환
        UI_Create-->>Player: 생성 실패 메시지 표시
    end
    deactivate UI_Create

    Player->>UI_Attack: 페이지 접속 (몬스터 공격)
    activate UI_Attack
    UI_Attack->>Session: getAttribute("myDnFCharacter")
    Session-->>UI_Attack: 캐릭터 객체 반환
    UI_Attack->>Battle: 몬스터공격(플레이어id, character)
    activate Battle
    Note over Battle: 플레이어 ID 체크 및 캐릭터 null 체크
    Battle->>Model: 스킬발동()
    Model-->>Battle: 데미지 계산 값 반환
    Battle->>Model: get스킬명()
    Model-->>Battle: 스킬명 반환
    Note over Battle: 데미지에 따른 공격 등급 판정 (S/A/B급)
    Battle-->>UI_Attack: 전투 결과 메시지 반환
    deactivate Battle
    UI_Attack-->>Player: 공격 데미지 및 등급 결과 출력
    deactivate UI_Attack

    %% [시나리오 3] 아이템 획득
    Player->>UI_Item: 아이템 획득 요청 (아이템명, 타입, 가치)
    activate UI_Item
    UI_Item->>Session: getAttribute("myDnFCharacter")
    Session-->>UI_Item: 캐릭터 객체 반환
    UI_Item->>Battle: 아이템획득(플레이어id, character, 아이템명, 타입, 가치)
    activate Battle
    Note over Battle: 플레이어 ID 체크 및 캐릭터 null 체크
    
    Note over Item: 인스턴스 생성 (new 아이템)
    Battle->>Item: 아이템 객체 생성 (가치에 따른 등급 판정)
    Battle->>Model: get인벤토리()
    Model-->>Battle: 인벤토리 객체 반환
    Battle->>Inventory: 아이템추가(newItem)
    activate Inventory
    alt 인벤토리 용량 여유 있음 (< 10)
        Inventory->>Inventory: 아이템리스트에 추가
        Inventory-->>Battle: true 반환
        Battle-->>UI_Item: "아이템 획득! 인벤토리에 추가되었습니다."
    else 인벤토리 가득 참 (>= 10)
        Inventory-->>Battle: false 반환
        deactivate Inventory
        Battle-->>UI_Item: "인벤토리가 가득 차 아이템을 획득할 수 없습니다."
    end
    deactivate Battle
    UI_Item-->>Player: 아이템 획득 결과 및 등급 출력
    deactivate UI_Item

    Player->>UI_Guild: 길드 가입 신청 (길드명 입력)
    activate UI_Guild
    UI_Guild->>Session: getAttribute("globalGuild")
    alt 기본 길드가 세션에 없을 때
        Note over Guild: 인스턴스 생성 (new 길드("아라드수호대"))
        UI_Guild->>Guild: 테스트용 기본 길드 생성
        UI_Guild->>Session: setAttribute("globalGuild", guild)
    end
    Session-->>UI_Guild: 길드 객체 반환
    UI_Guild->>Session: getAttribute("myDnFCharacter")
    Session-->>UI_Guild: 캐릭터 객체 반환
    
    alt 입력한 길드명이 존재(일치)할 때
        UI_Guild->>Battle: 길드가입(플레이어id, guild, character)
        activate Battle
        Battle->>Guild: 캐릭터가입(character)
        activate Guild
        alt 길드 정원 미달 (< 5)
            Guild->>Guild: 캐릭터리스트에 추가
            Guild-->>Battle: "가입 완료 메시지"
        else 길드 정원 초과 (>= 5)
            Guild-->>Battle: "정원 초과 메시지"
        end
        deactivate Guild
        Battle-->>UI_Guild: 결과 메시지 반환
        deactivate Battle
    else 길드명이 일치하지 않을 때
        Note over UI_Guild: "서버에 해당 이름의 길드가 존재하지 않습니다."
    end
    UI_Guild->>Guild: get현재인원()
    activate Guild
    Guild-->>UI_Guild: 현재 인원수 반환
    deactivate Guild
    UI_Guild-->>Player: 길드 가입 결과 및 현재 길드 인원 출력
    deactivate UI_Guild