package toyproject.demo.repository;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;

import java.util.List;

public interface PostRepository {
    public void insert(Post post);
    public void update(Post post);
    public List<Post> findAll();
    public List<Post> findByUser(String id);
    public List<Post> findByContents(String contents);
    public List<Post> findPostOfFollower(User user);
}
