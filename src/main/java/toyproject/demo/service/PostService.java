package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class PostService {
    private final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public void submit(Post post){
        post.setDate(LocalDateTime.now());
        postRepository.insert(post);
    }

    public List<Post> findPost(Post post){
        return postRepository.findPost(post);
    }

    public void delete(Post post){
        postRepository.delete(post);
    }

    public void modify(Post post){
        postRepository.update(post);
    }


    public List<Post> search(User user, Post post, LocalDate formerDate, LocalDate afterDate){
        return postRepository.search(user, post, formerDate, afterDate);
    }

    public List<Post> findMyPostByContents(Post post, User user){
        return postRepository.findMyPostByContents(post.getContents(), user);
    }

    public List<Post> findPostByFollower(User user){
        return postRepository.findPostOfFollower(user);
    }

    public List<Post> findAllLikePost(User user){
        return postRepository.findAllLikePost(user);
    }

}
