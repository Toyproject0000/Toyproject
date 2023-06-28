package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.User;
import toyproject.demo.repository.FollowRepository;

import java.util.List;

@Service
public class FollowService {
    private final FollowRepository followRepository;

    public FollowService(FollowRepository followRepository) {
        this.followRepository = followRepository;
    }

    public void add(Follow follow){
        followRepository.insert(follow);
    }

    public void remove(Follow follow){
        followRepository.delete(follow);
    }

    public List<User> findFollower(User user){
        return followRepository.findAllFollower(user.getId());
    }

    public List<User> findFollowing(User user){
        return followRepository.findAllFollowing(user.getId());
    }
}
