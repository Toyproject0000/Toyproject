package toyproject.demo.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.PostLike;
import toyproject.demo.domain.ReplyLike;
import toyproject.demo.service.ReplyLikeService;

@RestController("/Reply-like")
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
    public String add(ReplyLike replylike){
        try {
            replyLikeService.add(replylike);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/remove")
    public String remove(ReplyLike replylike){
        try {
            replyLikeService.add(replylike);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }
}
