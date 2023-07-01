package toyproject.demo.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.PostLike;
import toyproject.demo.service.PostLikeService;

@RestController
@RequestMapping("/post-like")
public class PostLikeController {
    /*
     * 좋아요 추가
     * 좋아요 삭제
     * */

    private final PostLikeService postLikeService;

    public PostLikeController(PostLikeService postLikeService) {
        this.postLikeService = postLikeService;
    }

    @PostMapping("/add")
    public String add(PostLike postLike){
        try {
            postLikeService.add(postLike);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }

    @PostMapping("/remove")
    public String remove(PostLike postLike){
        try {
            postLikeService.remove(postLike);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; // 작성했던 글 내용 그대로 다시 쓸수있는지 아니면 내가 다시 보내줘야되는지 물어보자
        }
    }
}
