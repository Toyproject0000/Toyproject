package toyproject.demo.howtouse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BlockControllerHowToUse {
    @GetMapping("/block/user")
    public String blockUser(){
        return "block/user";
    }

    @GetMapping("/block/post")
    public String blockPost(){
        return "block/post";
    }

    @GetMapping("/report/user")
    public String reportUser(){
        return "report/user";
    }

    @GetMapping("/report/post")
    public String reportPost( ){
        return "report/post";
    }

    @GetMapping("/cancel/block/user")
    public String cancelBlockUser(){
        return "block/cancel-user";
    }

    @GetMapping("/cancel/report/user")
    public String cancelReportUser(){
        return "report/cancel-user";
    }

    @GetMapping("/cancel/block/post")
    public String cancelBlockPost(){
        return "block/cancel-post";
    }

    @GetMapping("/cancel/report/post")
    public String cancelReportPost(){
        return "report/cancel-post";
    }

    @GetMapping("/find/block/user")
    public String findBlockUser(){
        return "block/find-user";
    }

    @GetMapping("/find/block/post")
    public String findBlockPost(){
        return "block/find-post";
    }

    @GetMapping("/find/report/user")
    public String findReportUser(){
        return "report/find-user";
    }

    @GetMapping("/find/report/post")
    public String findReportPost(){
        return "report/find-post";
    }
}
