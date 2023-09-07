package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/reply-like")
public class ReplyLikeControllerHowToUse {

    @GetMapping("/add")
    public String add(){
        return "/replyLike/add";
    }

    @GetMapping("/remove")
    public String remove(){
        return "/replyLike/remove";
    }
}
