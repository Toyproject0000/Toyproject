package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.converter.PostLikeConverter;
import toyproject.demo.domain.DTO.PostLikeWithTokenDTO;
import toyproject.demo.domain.PostLike;
import toyproject.demo.service.JwtTokenUtil;
import toyproject.demo.service.PostLikeService;

@RestController
@RequestMapping("/post-like")
@RequiredArgsConstructor
public class PostLikeController {
    /*
     * 좋아요 추가
     * 좋아요 삭제
     * */

    private final PostLikeService postLikeService;
    private final JwtTokenUtil tokenUtil;
    private final PostLikeConverter converter;

    @PostMapping("/add")
    public String add(@RequestBody PostLikeWithTokenDTO tokenPostLike){
        try {
            tokenUtil.parseJwtToken(tokenPostLike.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        PostLike postLike = converter.convert(tokenPostLike);
        try {
            postLikeService.add(postLike);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PostMapping("/remove")
    public String remove(@RequestBody PostLikeWithTokenDTO tokenPostLike){
        try {
            tokenUtil.parseJwtToken(tokenPostLike.getToken());
        }catch (Exception e){
            return "잘못된 접근입니다.";
        }
        PostLike postLike = converter.convert(tokenPostLike);
        try {
            postLikeService.remove(postLike);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }
}
