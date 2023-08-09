package toyproject.demo.repository;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;

import java.util.List;

public interface BlockRepository {
    void blockUser(String userId, String id);

    void blockPost(String userId, Long postId);

    void reportUser(String userId, String id, String reason);

    void reportPost(String userId, Long postId, String reason);

    void cancelBlockUser(String userId, String id);

    void cancelReportUser(String userId, String id);
    void cancelBlockPost(String userId, Long postId);
    void cancelReportPost(String userId, Long postId);

    List<User> findBlockUser(String userId);

    List<Post> findBlockPost(String userId);

    List<Post> findReportPost(String userId);

    List<User> findReportUser(String userId);
}
