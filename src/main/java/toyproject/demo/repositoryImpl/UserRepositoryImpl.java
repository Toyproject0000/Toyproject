package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.DTO.ProfileViewDTO;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

import java.util.List;

@Repository
public class UserRepositoryImpl implements UserRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;
    private final RowMapper profileRowMapper;
    private final RowMapper profileViewRowMapper;

    public UserRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.profileViewRowMapper = BeanPropertyRowMapper.newInstance(ProfileViewDTO.class);
        this.profileRowMapper = BeanPropertyRowMapper.newInstance(ProfileDTO.class);
        this.rowMapper = BeanPropertyRowMapper.newInstance(User.class);
    }

    @Override
    public void insert(User user) {
        jdbcTemplate.update("INSERT INTO user (id, root, password, name, phone_number, gender, birth, nickname) " +
                "VALUES (?, ? ,?, ?, ?, ?, ? , ?)", user.getId(), user.getRoot(), user.getPassword(), user.getName(), user.getPhoneNumber(), user.getGender(), user.getBirth(), user.getNickname());
    }

    @Override
    public void update(User user, String userId) {
        jdbcTemplate.update("UPDATE user SET password = COALESCE(?, password),  nickname = COALESCE(?, nickname), info = COALESCE(?, info), img_location = COALESCE(?, img_location), name = COALESCE(?, name), phone_number = COALESCE(?, phone_number), gender = COALESCE(?, gender), birth = coalesce(?, birth) WHERE id = ?",
                user.getPassword(), user.getNickname(), user.getInfo(), user.getImgLocation(),user.getName(),user.getPhoneNumber(),user.getGender(), user.getBirth(), userId);
    }

    /**
     *
     * @param user
     * 삭제하면 관련된 정보들 다 삭제되게 수정해야함.
     */

    @Override
    public void delete(User user) {
        jdbcTemplate.update("delete from user where id = ?", user.getId());
    }

    @Override
    public List<User> findById(String id, String userRoot) {
        return jdbcTemplate.query("select * from user where id = ? AND root = ?", rowMapper, id, userRoot);
    }

    @Override
    public List<User> findFollower(String userId) {
        return jdbcTemplate.query("select * from follows where followed_user_id = ?", rowMapper, userId);
    }

    @Override
    public List<User> findUserByNameAndPhone(User user) {
        return jdbcTemplate.query("select * from user where name = ? And phoneNumber = ?", rowMapper, user.getName(), user.getPhoneNumber());
    }

    @Override
    public List<User> findUserByNameAndPhoneAndId(User user) {
        return jdbcTemplate.query("select * from user where name = ? And phone_number = ? AND id = ? and root = ?", rowMapper, user.getName(), user.getPhoneNumber(), user.getId(), user.getRoot());
    }

    @Override
    public List<User> findNickname(User user) {
        return jdbcTemplate.query("select * from user where nickname = ?", rowMapper, user.getNickname());
    }

    @Override
    public List<User> findEmail(User user) {
        return jdbcTemplate.query("select * from user where id = ? and root = ?", rowMapper, user.getId(), user.getRoot());
    }

    @Override
    public void setPassword(User user) {
        jdbcTemplate.update("UPDATE user SET password = ?  WHERE id = ?", user.getPassword(), user.getId());
    }

    @Override
    public List<ProfileViewDTO> findUser(String id, String root) {
        return jdbcTemplate.query(
                "SELECT u.*, " +
                        "(SELECT COUNT(*) FROM follow f1 WHERE f1.followedUserId = u.id) AS following, " +
                        "(SELECT COUNT(*) FROM follow f2 WHERE f2.followingUserId = u.id) AS follower " +
                        "FROM user u " +
                        "WHERE u.id = ? and u.root = ?", profileViewRowMapper, id, root);
    }

    @Override
    public List<ProfileDTO> userProfile(String id, String root) {
        return jdbcTemplate.query("select u.*, (SELECT COUNT(*) FROM follow f1 WHERE f1.followedUserId = u.id) AS following, (SELECT COUNT(*) FROM follow f2 WHERE f2.followingUserId = u.id) AS follower from user u where id = ? and root = ?", profileRowMapper,id, root);
    }
}
