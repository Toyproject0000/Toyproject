package toyproject.demo.Controller.완료;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.PostService;


import java.util.*;

@RestController
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainController {
    private final PostService postService;

    @PostMapping(value = "/recommend")
    public List<Post> recommend(@RequestBody User user) {
        return postService.recommend(user.getId());
    }

    @PostMapping("/recommend/category")
    public List<Post> recommendWithCategory(@RequestBody String category){
        return postService.recommendWithCategory(category);
    }

}
