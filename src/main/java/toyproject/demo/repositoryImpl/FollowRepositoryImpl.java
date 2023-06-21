package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.Post;
import toyproject.demo.repository.FollowRepository;


import java.time.LocalDateTime;
import java.util.List;
@Repository
public class FollowRepositoryImpl implements FollowRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;

    public FollowRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(Follow.class);
    }
    @Override
    public void insert(Follow follow) {
        jdbcTemplate.update("insert into follow (followingUserId, followedUserId, day) values (?,?,?)"
                , follow.getFollowingUserId(), follow.getFollowedUserId(), LocalDateTime.now());
    }

    @Override
    public void delete(Follow follow) {
        jdbcTemplate.update("delete from follow where followingUserId = ? And followedUserId = ?", follow.getFollowingUserId(), follow.getFollowedUserId());
    }

    @Override
    public List<Follow> findAllFollower(String userId) {
        return jdbcTemplate.query("select * from follow where followedUserId = ?", rowMapper,userId);
    }

    @Override
    public List<Follow> findAllFollowing(String userId) {
        return jdbcTemplate.query("select * from follow where followingUserId = ?", rowMapper,userId);
    }
}
