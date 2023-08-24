package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import toyproject.demo.converter.PostConverter;
import toyproject.demo.converter.UserConverter;
import toyproject.demo.domain.DTO.PostWithTokenDTO;
import toyproject.demo.domain.DTO.UserWithTokenDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.JwtTokenUtil;
import toyproject.demo.service.PostService;


import java.util.*;

@RestController
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainController {
    private final PostService postService;
    private final PostConverter postConverter;
    private final JwtTokenUtil tokenUtil;

    @PostMapping(value = "/recommend", produces = "application/json;charset=UTF-8")
    public List<Post> recommend(@RequestBody UserWithTokenDTO tokenUser) {
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return null;
        }
        return postService.recommend(tokenUser.getId());
    }

    @PostMapping(value = "/recommend/category", produces = "application/json;charset=UTF-8")
    public List<Post> recommendWithCategory(@RequestBody PostWithTokenDTO tokenPost){
        try {
            tokenUtil.parseJwtToken(tokenPost.getToken());
        }catch (Exception e){
            return null;
        }

        return postService.recommendWithCategory(tokenPost.getCategory());
    }

}
