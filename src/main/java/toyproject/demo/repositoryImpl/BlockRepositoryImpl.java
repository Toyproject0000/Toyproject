package toyproject.demo.repositoryImpl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.BlockRepository;

import java.time.LocalDateTime;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class BlockRepositoryImpl implements BlockRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<User> userRowMapper = BeanPropertyRowMapper.newInstance(User.class);
    private final RowMapper<Post> postRowMapper = BeanPropertyRowMapper.newInstance(Post.class);
    private final RowMapper<ProfileViewDTO> profileRowMapper = BeanPropertyRowMapper.newInstance(ProfileViewDTO.class);
    @Override
    public void blockUser(String userId, String id, String userRoot, String root) {
        jdbcTemplate.update("insert into block (blocking_user_id, blocked_user_id, date, blocking_user_root, blocked_user_root) values (?, ?, ?, ? , ?)", userId, id, LocalDateTime.now(), userRoot, root);
    }

    @Override
    public void blockPost(String userId, Long postId, String root) {
        jdbcTemplate.update("insert into block (blocking_user_id, blocked_post_id, date, blocking_user_root) values (?, ?, ?, ?)", userId, postId, LocalDateTime.now(), root);
    }

    @Override
    public void reportUser(String userId, String id, String reason, String userRoot, String root) {
        jdbcTemplate.update("insert into report (reporting_user_id, reported_user_id, date, reason, reporting_user_root, reported_user_root) values (?, ?, ?, ?, ?, ?)", userId, id, LocalDateTime.now(), reason, userRoot, root);
    }

    @Override
    public void reportPost(String userId, Long postId, String reason, String userRoot) {
        jdbcTemplate.update("insert into report (reporting_user_id, reported_post_id, date, reason, reporting_user_root) values (?, ?, ?, ?, ?)", userId, postId, LocalDateTime.now(), reason, userRoot);
    }

    @Override
    public void cancelBlockUser(String userId, String id,String userRoot, String root) {
        jdbcTemplate.update("delete from block where blocking_user_id=? and blocked_user_id=? and blocking_user_root = ? and blocked_user_root = ?", userId, id, userRoot, root);
    }

    @Override
    public void cancelReportUser(String userId, String id, String userRoot, String root) {
        jdbcTemplate.update("delete from report where reporting_user_id=? and reported_user_id = ? and reporting_user_root=? and reported_user_root = ?", userId, id, userRoot, root);
    }

    @Override
    public void cancelBlockPost(String userId, Long id, String root) {
        jdbcTemplate.update("delete from block where blocking_user_id=? and blocked_post_id=? and blocking_user_root = ?", userId, id, root);
    }

    @Override
    public void cancelReportPost(String userId, Long id, String root) {
        jdbcTemplate.update("delete from report where reporting_user_id=? and reported_post_id=? and reporting_user_root=?", userId, id, root);
    }

    @Override
    public List<ProfileViewDTO> findBlockUser(String userId, String root) {
        return jdbcTemplate.query("SELECT u.* FROM user u INNER JOIN block b ON u.id = b.blocked_user_id WHERE b.blocking_user_id = ? and b.blocking_user_root = ?", profileRowMapper, userId, root);
    }

    @Override
    public List<Post> findBlockPost(String userId, String root) {
        return jdbcTemplate.query("SELECT p.*, (SELECT root FROM user u WHERE u.id = ? and u.root = ?) AS root, (SELECT COUNT(*) FROM postLike pl WHERE pl.post_id = p.id) AS likeCount FROM post p INNER JOIN block r ON p.id = r.blocked_post_id WHERE blocking_user_id = ? and blocking_user_root = ?", postRowMapper, userId, root, userId, root);
    }

    @Override
    public List<Post> findReportPost(String userId, String userRoot) {
        return jdbcTemplate.query("select p.*, (SELECT root FROM user u WHERE u.id = ? and u.root = ?) AS root, (SELECT COUNT(*) FROM postLike pl WHERE pl.post_id = p.id) AS likeCount from post p INNER JOIN report r on p.id = r.reported_post_id where reporting_user_id = ? and reporting_user_root = ?", postRowMapper, userId, userRoot, userId, userRoot);
    }

    @Override
    public List<ProfileViewDTO> findReportUser(String userId, String userRoot) {
        return jdbcTemplate.query("select u.* from user u INNER JOIN report r on u.id = r.reported_user_id where reporting_user_id=? and reporting_user_root = ?", profileRowMapper, userId, userRoot);
    }
}