package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.ReplyLikeConverter;
import toyproject.demo.domain.DTO.ReplyLikeWithTokenDTO;
import toyproject.demo.domain.ReplyLike;
import toyproject.demo.service.JwtTokenUtil;
import toyproject.demo.service.ReplyLikeService;

@RestController
@RequestMapping("/reply-like")
@RequiredArgsConstructor
public class ReplyLikeController {

    /*
    * 좋아요
    * 좋아요 취소
    * */

    private final ReplyLikeService replyLikeService;
    private final JwtTokenUtil tokenUtil;
    private final ReplyLikeConverter converter;

    @PostMapping("/add")
    public String add(@RequestBody ReplyLikeWithTokenDTO tokenReplyLike){
        try {
            tokenUtil.parseJwtToken(tokenReplyLike.getToken());
        }
        catch (Exception e){
            return "잘못된 접근입니다.";
        }
        ReplyLike replyLike = converter.convert(tokenReplyLike);
        try {
            replyLikeService.add(replyLike);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PostMapping("/remove")
    public String remove(@RequestBody ReplyLikeWithTokenDTO tokenReplyLike){
        try {
            tokenUtil.parseJwtToken(tokenReplyLike.getToken());
        }
        catch (Exception e){
            return "잘못된 접근입니다.";
        }
        ReplyLike replyLike = converter.convert(tokenReplyLike);
        try {
            replyLikeService.remove(replyLike);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }
}
