package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.User;
import toyproject.demo.repository.FollowRepository;


import java.time.LocalDateTime;
import java.util.List;
@Repository
public class FollowRepositoryImpl implements FollowRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;
    private final RowMapper userRowMapper;

    public FollowRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(Follow.class);
        this.userRowMapper = BeanPropertyRowMapper.newInstance(User.class);
    }
    @Override
    public void insert(Follow follow) {
        jdbcTemplate.update("insert into follow (followingUserId, followedUserId, date, following_user_root, followed_user_root) values (?,?,?,?,?)"
                , follow.getFollowingUserId(), follow.getFollowedUserId(), LocalDateTime.now(), follow.getFollowingUserRoot(), follow.getFollowedUserRoot());
    }

    @Override
    public void delete(Follow follow) {
        jdbcTemplate.update("delete from follow where followingUserId = ? And followedUserId = ? and following_user_root = ? and followed_user_root=?", follow.getFollowingUserId(), follow.getFollowedUserId(), follow.getFollowingUserRoot(), follow.getFollowedUserRoot());
    }

    @Override
    public List<User> findAllFollower(String userId, String root) {
        return jdbcTemplate.query("SELECT u.* FROM user u left join follow f ON u.id = f.followingUserId  and u.root = f.following_user_root  WHERE f.followedUserId = ? and f.followed_user_root = ? ", userRowMapper, userId, root);
    }

    @Override
    public List<User> findAllFollowing(String userId, String root) {
        return jdbcTemplate.query("SELECT u.* FROM user u JOIN follow f ON u.id = f.followedUserId and u.root = f.followed_user_root WHERE f.followingUserId = ? and f.following_user_root=?", userRowMapper,userId, root);
    }
}