package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/post-like")
@Controller
public class PostLikeControllerHowToUse {
    @GetMapping("/add")
    public String add(){
        return "postlike/add";
    }

    @GetMapping("/remove")
    public String remove(){
        return "postlike/remove";
    }
}

