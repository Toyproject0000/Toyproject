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
import java.util.Base64;
import java.util.List;

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

    public Post findPost(Post post) throws IOException {
        Post findPost = postRepository.findPost(post).get(0);
        Path path = Paths.get(findPost.getImgLocation());
        byte[] imageBytes = Files.readAllBytes(path);
        String Image = Base64.getEncoder().encodeToString(imageBytes);
        findPost.setImg(Image);

        return findPost;
    }

    public void delete(Post post){
        Post findPost = postRepository.findPost(post).get(0);
        String imgLocation = findPost.getImgLocation();
        new File(imgLocation).delete();

        postRepository.delete(post);
    }

    public void modify(Post post){
        postRepository.update(post);
    }


    public List<Post> search(Post post, LocalDate formerDate, LocalDate afterDate) throws IOException {
        List<Post> posts = postRepository.search(post, formerDate, afterDate);
        setPostImg(posts);
        return posts;
    }


    public List<Post> findPostByFollower(User user) throws IOException {
        List<Post> posts = postRepository.findPostOfFollower(user);
        setPostImg(posts);
        return posts;
    }

    public List<Post> findAllLikePost(User user) throws IOException {
        List<Post> posts = postRepository.findAllLikePost(user);
        setPostImg(posts);
        return posts;
    }

    public List<Post> findByCategory(String category, Integer num) throws IOException {
        List<Post> posts = postRepository.findByCategory(category, num);
        for (Post post : posts) {
            Path imagePath = Paths.get(post.getImgLocation());
            byte[] imageBytes = Files.readAllBytes(imagePath);
            String base64EncodedImage = Base64.getEncoder().encodeToString(imageBytes);
            post.setImg(base64EncodedImage);
        }
        return posts;
    }


    private static void setPostImg(List<Post> posts) throws IOException {
        for (Post findPost : posts) {
            Path path = Paths.get(findPost.getImgLocation());
            byte[] imageBytes = Files.readAllBytes(path);
            String Image = Base64.getEncoder().encodeToString(imageBytes);
            findPost.setImg(Image);
        }
    }


}
