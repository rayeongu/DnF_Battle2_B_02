```mermaid
sequenceDiagram
    autonumber
    participant UI as Join_Guild_UI
    participant PL as 플레이어
    participant GD as 길드
    participant CH as 캐릭터

    UI->>PL: 플레이어체크(id)
    activate PL
    PL-->>UI: true
    deactivate PL

    alt 인증 성공
        UI->>GD: 캐릭터가입(c)
        activate GD
        
        %% 캐릭터의 역할을 추가한 부분
        GD->>CH: 캐릭터 정보 확인 (get캐릭터명/레벨)
        activate CH
        CH-->>GD: "광전사", Lv.10 정보 반환
        deactivate CH

        Note over GD: 정원 체크 (최대 5명)
        
        alt 정원 여유 있음
            GD->>GD: 캐릭터리스트.add(c)
            GD-->>UI: "광전사 가입 성공"
        else 정원 초과
            GD-->>UI: "정원 초과로 가입 실패"
        end
        deactivate GD
    end