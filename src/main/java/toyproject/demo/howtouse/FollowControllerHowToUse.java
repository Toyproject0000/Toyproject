package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/follow")
public class FollowControllerHowToUse {
    @GetMapping("/add")
    public String add(){
        return "/follow/add";
    }

    @GetMapping("/remove")
    public String remove(){
        return "/follow/remove";
    }

    @GetMapping("/find-follower")
    public String findFollower(){
        return "/follow/find-follower";
    }
    @GetMapping("/find-following")
    public String findFollowing(){
        return "/follow/find-following";
    }
}
