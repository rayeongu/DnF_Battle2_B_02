package Dnf;
import java.util.*;

public class 인벤토리 {

    public List<아이템> 아이템리스트 = new ArrayList<>(); 
    public int 최대용량 = 10;

    public boolean 아이템추가(아이템 item) {
        if (아이템리스트.size() < 최대용량) {
            아이템리스트.add(item);
            return true;
        }
        return false;
    }
}