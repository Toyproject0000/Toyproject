package toyproject.demo.repository;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;

import java.time.LocalDate;
import java.util.List;

public interface PostRepository {
    public void insert(Post post);
    public void update(Post post);
    public void delete(Post post);
    public List<Post> findAll();
    public List<Post> findByUser(User user);
    public List<Post> findByContents(String contents);
    public List<Post> findMyPostByContents(String contents, User user);
    public List<Post> findPostOfFollower(User user);
    public List<Post> findAllLikePost(User user);
    public List<Post> findPostBySpecificDate(LocalDate date);
    public List<Post> findPostAfterSpecificDate(LocalDate date);
}
