package toyproject.demo.repository;

import toyproject.demo.domain.Follow;
import toyproject.demo.domain.Post;

import java.util.List;

public interface FollowRepository {
    public void insert(Follow follow);
    public void delete(Follow follow);
    public List<Follow> findAllFollower(String userId);
    public List<Follow> findAllFollowing(String userId);
}
