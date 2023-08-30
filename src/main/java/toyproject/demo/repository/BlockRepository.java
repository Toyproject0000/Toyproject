package toyproject.demo.repository;

import toyproject.demo.domain.DTO.BlockUserDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;

import java.util.List;

public interface BlockRepository {
    void blockUser(String userId, String id, String userRoot, String root);
    void blockPost(String userId, Long postId, String root);
    void reportUser(String userId, String id, String reason, String userRoot, String root);
    void reportPost(String userId, Long postId, String reason, String userRoot);
    void cancelBlockUser(String userId, String id, String userRoot, String root);
    void cancelReportUser(String userId, String id, String userRoot, String root);
    void cancelBlockPost(String userId, Long postId, String root);
    void cancelReportPost(String userId, Long postId, String root);
    List<User> findBlockUser(String userId, String root);
    List<Post> findBlockPost(String userId, String root);
    List<Post> findReportPost(String userId, String userRoot);
    List<User> findReportUser(String userId, String userRoot);
}
