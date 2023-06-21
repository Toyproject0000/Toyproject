package toyproject.demo.repositoryImpl;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;

import java.util.List;

public class PostRepositoryImpl implements PostRepository {
    @Override
    public void insert(Post post) {

    }

    @Override
    public void update(Post post) {

    }

    @Override
    public List<Post> findAll() {
        return null;
    }

    @Override
    public List<Post> findByUser(String id) {
        return null;
    }

    @Override
    public List<Post> findByContents(String contents) {
        return null;
    }

    @Override
    public List<Post> findPostOfFollower(User user) {
        return null;
    }
}
