package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.PostService;

import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainController {
    private final PostService postService;

    @PostMapping("/recommend")
    public List<Post> recommend(@RequestBody User user) throws IOException {
        int page = 0;
        List<Post> result = postService.findByCategory(user.getId(), page);

        int size = result.size()-1;

        Set<Integer> num = new HashSet<>();
        Random random = new Random();

        while (num.size()<Math.min(10, size)){
            num.add(random.nextInt(size));
        }

        List<Post> posts = new ArrayList<>();

        for (int i : num) {
            if (result.get(i).getId()!=null){
                posts.add(result.get(i));
            }
        }

        posts.sort(Comparator.comparing(Post::getDate, Comparator.reverseOrder()));


        return posts;
    }

    @PostMapping("/recommend/category")
    public List<Post> recommendWithCategory(@RequestBody String category,@RequestBody Integer page) throws IOException {
//        return postService.findByCategory(category, 10, page);
        return null;
    }



}
