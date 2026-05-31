package Dnf;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
    public String 길드명;
    public List<캐릭터> 캐릭터리스트 = new ArrayList<>();
    final int 최대인원 = 5;

    public 길드(String 길드명) { this.길드명 = 길드명; }

    public String 캐릭터가입(캐릭터 c) {
        if (캐릭터리스트.size() < 최대인원) {
            캐릭터리스트.add(c);
            return "가입 성공";
        }
        return "정원 초과로 가입 실패";
    }
}