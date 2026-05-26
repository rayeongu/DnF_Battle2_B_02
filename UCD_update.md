```mermaid
graph LR
    %% Actor 정의
    Player((플레이어))

    %% System Boundary 내 UseCase 정의
    subgraph "DnF_Battle_B_0X팀 시스템"
        UC1[캐릭터생성]
        UC2[몬스터공격]
        UC3[플레이어체크]
        UC4[아이템획득]
        UC5[길드가입]
    end

    %% 관계 설정
    Player --- UC1
    Player --- UC2
    Player --- UC4
    Player --- UC5

    %% 포함 관계 (Include)
    UC1 -.->|"&lt;&lt;include&gt;&gt;"| UC3
    UC2 -.->|"&lt;&lt;include&gt;&gt;"| UC3
    UC4 -.->|"&lt;&lt;include&gt;&gt;"| UC3
    UC5 -.->|"&lt;&lt;include&gt;&gt;"| UC3

    %% 스타일 설정
    style Player fill:#f9f,stroke:#333,stroke-width:2px
    style UC3 fill:#fff,stroke-dasharray: 5 5