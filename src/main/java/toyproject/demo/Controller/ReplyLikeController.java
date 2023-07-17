package toyproject.demo.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.ReplyLike;
import toyproject.demo.service.ReplyLikeService;

@RestController
@RequestMapping("/reply-like")
public class ReplyLikeController {

    /*
    * 좋아요
    * 좋아요 취소
    *
    * */

    private final ReplyLikeService replyLikeService;

    public ReplyLikeController(ReplyLikeService replyLikeService) {
        this.replyLikeService = replyLikeService;
    }

    @PostMapping("/add")
    public String add(@RequestBody ReplyLike replylike){
        try {
            replyLikeService.add(replylike);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/remove")
    public String remove(@RequestBody ReplyLike replylike){
        try {
            replyLikeService.add(replylike);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }
}
