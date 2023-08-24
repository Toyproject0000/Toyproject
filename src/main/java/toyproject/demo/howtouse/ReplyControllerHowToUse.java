package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reply")
public class ReplyControllerHowToUse {
    @GetMapping("/add")
    public String add(){
        return "reply/add";
    }

    @GetMapping("/delete")
    public String delete(){
        return "reply/delete";
    }
    @GetMapping("/edit")
    public String edit(){
        return "reply/edit";
    }

    @GetMapping("/post")
    public String findPost(){
        return "reply/post";
    }
}

