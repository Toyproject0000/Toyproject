package toyproject.demo.howtouse;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.ReplyLikeConverter;
import toyproject.demo.domain.DTO.ReplyLikeWithTokenDTO;
import toyproject.demo.domain.ReplyLike;
import toyproject.demo.service.JwtTokenUtil;
import toyproject.demo.service.ReplyLikeService;

@Controller
@RequestMapping("/reply-like")
public class ReplyLikeController {

    @PostMapping("/add")
    public String add(){
        return "/replyLike/add";
    }

    @PostMapping("/remove")
    public String remove(){
        return "/replyLike/remove";
    }
}
