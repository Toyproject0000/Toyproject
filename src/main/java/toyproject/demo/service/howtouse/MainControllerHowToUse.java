package toyproject.demo.service.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainControllerHowToUse {
    @GetMapping("/main/recommend")
    public String mainRecommend(){
        return "post/Main";
    }
}
