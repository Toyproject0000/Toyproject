package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/")
public class UserControllerHowToUse {

    @GetMapping(value = "/join")
    public String join(){
        return "user/join";
    }

    @GetMapping(value = "/login")
    public String login(){
        return "user/login";
    }

    @GetMapping(value = "/findId")
    public String findId(){
        return "user/findID";
    }

    @GetMapping(value = "/findPassword/email")
    public String findPasswordEmail(){
        return "user/findPassword-email";
    }

    @GetMapping(value = "/findPassword/check")
    public String findPassword(){
        return "user/findPassword-check";
    }

    @GetMapping(value = "/setPassword")
    public String setPassword(){
        return "user/setPassword";
    }

    @GetMapping(value = "/remove")
    public String delete(){
            return "user/remove";
    }
    @GetMapping(value = "/nickname")
    public String duplicateNickname(){
        return "user/nickname";
    }

    @GetMapping(value = "/authentication")
    public String authentication(){
        return "user/authentication";
    }

    @GetMapping(value = "/authentication-check")
    public String check(){
        return "user/authentication-check";
    }

    @GetMapping(value = "/profile")
    public String profile(){
        return "user/profile";
    }

    @GetMapping(value = "/profile/set")
    public String profileSet(){
        return "user/profile-set";
    }
}
