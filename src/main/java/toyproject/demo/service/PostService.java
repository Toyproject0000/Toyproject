package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;

import java.time.LocalDate;
import java.util.List;

@Service
public class PostService {
    private final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public void submit(Post post){
        postRepository.insert(post);
    }

    public void delete(Post post){
        postRepository.delete(post);
    }

    public void modify(Post post){
        postRepository.update(post);
    }

    public List<Post> findUserAllPost(User user){
        return postRepository.findByUser(user);
    }

    public List<Post> findPostBySpecificDate(LocalDate date){
        return postRepository.findPostBySpecificDate(date);
    }

    public List<Post> findPostAfterDate(LocalDate date){
        return postRepository.findPostAfterSpecificDate(date);
    }

    public List<Post> findPostByContents(Post post){
        return postRepository.findByContents(post.getContents());
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
