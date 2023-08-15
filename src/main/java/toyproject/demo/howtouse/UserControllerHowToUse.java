package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/")
public class UserControllerHowToUse {

    @GetMapping(value = "/join")
    public String join(){
        return "user/user-join";
    }

    @GetMapping(value = "/login")
    public String login(){
        return "user/user-login";
    }

    @GetMapping(value = "/findId")
    public String findId(){
        return "user/user-findID";
    }

    @GetMapping(value = "/findPassword/email")
    public String findPasswordEmail(){
        return "user/user-findPassword-email";
    }

    @GetMapping(value = "/findPassword/check")
    public String findPassword(){
        return "user/user-findPassword-check";
    }

    @GetMapping(value = "/setPassword")
    public String setPassword(){
        return "user/user-setPassword";
    }

//    @GetMapping(value = "/edit-user/user")
//    public String edit(){
//        return "user/user-edit";
//    }

    @GetMapping(value = "/remove")
    public String delete(){
            return "user/user-remove";
    }
    @GetMapping(value = "/nickname")
    public String duplicateNickname(){
        return "user/user-nickname";
    }

    @GetMapping(value = "/authentication")
    public String authentication(){
        return "user/user-authentication";
    }

    @GetMapping(value = "/authentication-check")
    public String check(){
        return "user/user-authentication-check";
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
