package toyproject.demo.repositoryImpl;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.DTO.BlockUserDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.BlockRepository;

import java.time.LocalDateTime;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class BlockRepositoryImpl implements BlockRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<BlockUserDTO> userRowMapper = BeanPropertyRowMapper.newInstance(BlockUserDTO.class);
    private final RowMapper<Post> postRowMapper = BeanPropertyRowMapper.newInstance(Post.class);
    @Override
    public void blockUser(String userId, String id) {
        jdbcTemplate.update("insert into block (blocking_user_id, blocked_user_id, date) values (?, ?, ?)", userId, id, LocalDateTime.now());
    }

    @Override
    public void blockPost(String userId, Long postId) {
        jdbcTemplate.update("insert into block (blocking_user_id, blocked_user_id, date) values (?, ?, ?)", userId, postId, LocalDateTime.now());
    }

    @Override
    public void reportUser(String userId, String id, String reason) {
        jdbcTemplate.update("insert into report (reporting_user_id, reported_user_id, date, reason) values (?, ?, ?,)", userId, id, LocalDateTime.now(), reason);
    }

    @Override
    public void reportPost(String userId, Long postId, String reason) {
        jdbcTemplate.update("insert into report (reporting_user_id, reported_user_id, date, reason) values (?, ?, ?, ?)", userId, postId, LocalDateTime.now(), reason);
    }

    @Override
    public void cancelBlockUser(String userId, String id) {
        jdbcTemplate.update("delete from block where blocking_user_id=? and blocked_user_id=?", userId, id);
    }

    @Override
    public void cancelReportUser(String userId, String id) {
        jdbcTemplate.update("delete from report where reporting_user_id=? and reported_user_id=?", userId, id);
    }

    @Override
    public void cancelBlockPost(String userId, Long id) {
        jdbcTemplate.update("delete from block where reporting_user_id=? and reported_post_id=?", userId, id);
    }

    @Override
    public void cancelReportPost(String userId, Long id) {
        jdbcTemplate.update("delete from report where reporting_user_id=? and reported_post_id=?", userId, id);
    }

    @Override
    public List<BlockUserDTO> findBlockUser(String userId) {
        return jdbcTemplate.query("SELECT u.* FROM user u INNER JOIN block b ON u.id = b.blocked_user_id WHERE b.blocking_user_id = ?", userRowMapper, userId);
    }

    @Override
    public List<Post> findBlockPost(String userId) {
        return jdbcTemplate.query("SELECT p.* FROM post p INNER JOIN block b ON p.id = b.blocked_post_id WHERE b.blocking_user_id = ?", postRowMapper, userId);
    }

    @Override
    public List<Post> findReportPost(String userId) {
        return jdbcTemplate.query("select p.* from post p INNER JOIN report r on p.id = r.reported_post_id where reporting_user_id=?", postRowMapper, userId);
    }

    @Override
    public List<BlockUserDTO> findReportUser(String userId) {
        return jdbcTemplate.query("select u.* from user u INNER JOIN report r on u.id = r.reported_user_id where reporting_user_id=?", userRowMapper, userId);
    }
}