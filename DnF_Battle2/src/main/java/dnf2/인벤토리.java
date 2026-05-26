package dnf2;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트;
    private int 최대용량 = 10;

    public 인벤토리() {
        this.아이템리스트 = new ArrayList<>();
    }

    public boolean 아이템추가(아이템 item) {
        if (아이템리스트.size() < 최대용량) {
            아이템리스트.add(item);
            return true;
        }
        return false;
    }

    public List<아이템> get아이템리스트() {
        return 아이템리스트;
    }
}