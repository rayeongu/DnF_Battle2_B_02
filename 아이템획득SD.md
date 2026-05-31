```mermaid
sequenceDiagram
    autonumber
    participant UI as Add_Item_UI
    participant PL as 플레이어
    participant CH as 캐릭터
    participant IV as 인벤토리
    participant IT as 아이템

    UI->>PL: 플레이어체크(pId)
    activate PL
    PL-->>UI: true / false
    deactivate PL

    alt 인증 성공 ("hero")
        UI->>IT: new 아이템(명, 타입, 가치)
        activate IT
        Note over IT: 가치에 따른 등급 부여 로직
        IT-->>UI: 아이템 객체 생성
        deactivate IT

        UI->>CH: 캐릭터.인벤토리 참조
        activate CH
        CH->>IV: 아이템추가(newItem)
        activate IV
        Note over IV: 용량 체크 (최대 10개)
        IV-->>CH: true / false
        deactivate IV
        CH-->>UI: 결과 반환
        deactivate CH
        
        Note right of UI: 성공/실패 메시지 출력
    else 인증 실패
        Note right of UI: "플레이어 인증 실패!" 반환
    end