package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @GetMapping("/main/recommend")
    public String mainRecommend(){
        return "post/Main";
    }
}
