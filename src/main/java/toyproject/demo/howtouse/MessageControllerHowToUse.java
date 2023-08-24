package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MessageControllerHowToUse {
    @GetMapping("message/send")
    public String sendMessage(){
        return "message/send";
    }

    @GetMapping("/message/findAll")
    public String findAllMessage(){
        return "message/findAll";
    }
    @GetMapping("/message/user")
    public String Message(){
        return "message/user";
    }

    @GetMapping("/message/search")
    public String searchMessage(){
        return "message/search";
    }
    @GetMapping("/message/deleteAll")
    public String deleteAllMessage(){
        return "message/deleteAll";
    }

    @GetMapping("/message/delete")
    public String deleteMessage(){
        return "message/delete";
    }
}
