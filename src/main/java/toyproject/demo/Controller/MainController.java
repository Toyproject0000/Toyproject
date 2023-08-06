package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import toyproject.demo.domain.Category;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.FindAlgorithm;
import toyproject.demo.service.PostService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController("/main")
@RequiredArgsConstructor
public class MainController {
    private final FindAlgorithm algorithm;
    private final PostService postService;

    @PostMapping("/recommend")
    public List<Post> recommend(@RequestBody User user) throws IOException {
        List<Category> categories = algorithm.findCategory(user.getId());

        List<Post> result = new ArrayList<>();

        String firstCategory = categories.get(0).getCategory();
        List<Post> firstPosts = postService.findByCategory(firstCategory, 5);

        result.addAll(firstPosts);

        String secondCategory = categories.get(1).getCategory();
        List<Post> secondPosts = postService.findByCategory(secondCategory, 3);

        result.add(1,secondPosts.get(0));
        result.add(4,secondPosts.get(1));
        result.add(7,secondPosts.get(2));

        String thirdCategory = categories.get(2).getCategory();
        List<Post> thirdPosts = postService.findByCategory(thirdCategory, 2);

        result.add(3, thirdPosts.get(0));
        result.add(7, thirdPosts.get(0));

        return result;
    }

    @PostMapping("/recommend/category")
    public List<Post> recommendWithCategory(String category) throws IOException {
        return postService.findByCategory(category, 10);
    }



}
