package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/post")
public class PostControllerHowToUse {

    @GetMapping("/submit")
    public String submitPost(){
        return "post/submit";
    }

    @GetMapping("edit")
    public String editConfirm(){
        return "post/edit";
    }

    @GetMapping("/delete")
    public String delete(){
        return "post/delete";
    }


    @GetMapping("/search")
    public String search(){
        return "post/search";
    }

    @GetMapping("/find-follower")
    public String findPostOfFollower(){
        return "post/follower";
    }

    @GetMapping("/find-likepost")
    public String findLikePost(){
        return "post/likepost";
    }
}
