package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.Category;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
    public void submitImg(Post post){
        postRepository.insertImg(post);
    }

    /**
     *
     * @param post
     */

    public void delete(Post post){
//        Post findPost = postRepository.findPost(post).get(0);
//        String imgLocation = findPost.getImgLocation();
//        new File(imgLocation).delete();

//        postRepository.delete(post);
    }

    public void modify(Post post){
        postRepository.update(post);
    }

    public List<Post> findByWriter(String id){
        return postRepository.findByWriter(id);
    }


    public List<Post> search(Post post, LocalDate formerDate, LocalDate afterDate) throws IOException {
        List<Post> posts = postRepository.search(post, formerDate, afterDate);
//        setPostImg(posts);
        return posts;
    }


    public List<Post> findPostByFollower(User user) throws IOException {
        List<Post> posts = postRepository.findPostOfFollower(user);

        return posts;
    }

    public List<Post> findAllLikePost(User user) throws IOException {
        List<Post> posts = postRepository.findAllLikePost(user);

        return posts;
    }

    public List<Post> recommend(String userId) {
        List<Post> result = postRepository.recommendByAlgorithm(userId);

        List<Post> posts = selectRandomPost(result);

        return posts;
    }

    public List<Post> recommendWithCategory(String category){
        List<Post> result = postRepository.recommendByCategory(category);

        List<Post> posts = selectRandomPost(result);

        return posts;
    }



    private static List<Post> selectRandomPost(List<Post> result) {
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

}
