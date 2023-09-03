package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.Category;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
public class PostService {
    private final PostRepository postRepository;
    private final FindAlgorithm algorithm;

    public void submit(Post post){
        post.setDate(LocalDateTime.now());
        postRepository.insert(post);
        algorithm.write(post);
    }
    /**
     *
     * @param post
     */

    public void delete(Post post){
        Long id = post.getId();
        Post findPost = postRepository.findPost(id).get(0);
        if (findPost.getImgLocation()!=null){
        String imgLocation = findPost.getImgLocation();
        new File(imgLocation).delete();}

        postRepository.delete(post);
    }

    public void modify(Post post){
        postRepository.update(post);
    }

    public List<Post> findByWriter(String id, String root){
        return postRepository.findByWriter(id, root);
    }


    public List<Post> search(Post post, LocalDate formerDate, LocalDate afterDate) throws IOException {
        List<Post> posts = postRepository.search(post, formerDate, afterDate);
        System.out.println("posts.size() = " + posts.size());
        return posts;
    }

    public List<Post> findPostByFollower(User user) {
        List<Post> posts = postRepository.findPostOfFollower(user);

        return posts;
    }

    public List<Post> findAllLikePost(User user){
        List<Post> posts = postRepository.findAllLikePost(user);

        return posts;
    }

    public List<Post> recommend(String userId, String userRoot) {
        List<Post> result = postRepository.recommendByAlgorithm(userId, userRoot);

        List<Post> posts = selectRandomPost(result);

        return posts;
    }

    public List<Post> recommendWithCategory(String category){
        List<Post> result = postRepository.recommendByCategory(category);

        List<Post> posts = selectRandomPost(result);

        return posts;
    }



    private static List<Post> selectRandomPost(List<Post> result) {
        int size = Math.max(1, result.size()-1);

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

}
