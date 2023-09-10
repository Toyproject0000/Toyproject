package toyproject.demo.repository;

import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;

import java.util.List;

public interface FollowRepository {
    public void insert(Follow follow);
    public void delete(Follow follow);
    public List<ProfileViewDTO> findAllFollower(String userId, String root);
    public List<ProfileViewDTO> findAllFollowing(String userId, String root);
}
