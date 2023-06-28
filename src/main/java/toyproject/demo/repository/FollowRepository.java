package toyproject.demo.repository;

import toyproject.demo.domain.Follow;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;

import java.util.List;

public interface FollowRepository {
    public void insert(Follow follow);
    public void delete(Follow follow);
    public List<User> findAllFollower(String userId);
    public List<User> findAllFollowing(String userId);
}
