package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

import java.util.List;

@Repository
public class UserRepositoryImpl implements UserRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;

    public UserRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(User.class);
    }

    @Override
    public void insert(User user) {
        jdbcTemplate.update("INSERT INTO user (id, password, name, phoneNumber,  gender) " +
                "VALUES (?, ?, ?, ?, ?, ?)", user.getId(), user.getPassword(), user.getName(), user.getPhoneNumber(), user.getGender());
    }

    @Override
    public void update(User user, String userId) {
        jdbcTemplate.update("UPDATE user SET password = COALESCE(?, password),  nickname = COALESCE(?, nickname), info = COALESCE(?, info), img_location = coalesce(?, img_location) WHERE id = ?",
                user.getPassword(), user.getNickname(), user.getInfo(), user.getImgLocation(), userId);
    }

    @Override
    public void delete(User user) {
        jdbcTemplate.update("delete from user where id = ?", user.getId());
    }

    @Override
    public List<User> findById(String id) {
        return jdbcTemplate.query("select * from user where id = ?", rowMapper, id);
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
        return jdbcTemplate.query("select * from user where name = ? And phoneNumber = ? AND id = ?", rowMapper, user.getName(), user.getPhoneNumber(), user.getId());
    }

    @Override
    public List<User> findNickname(User user) {
        return jdbcTemplate.query("select * from user where nickname = ?", rowMapper, user.getNickname());
    }

    @Override
    public List<User> findEmail(User user) {
        return jdbcTemplate.query("select * from user where id = ?", rowMapper, user.getId());
    }

    @Override
    public void setPassword(User user) {
        jdbcTemplate.update("UPDATE user SET password = ?  WHERE id = ?", user.getPassword(), user.getId());
    }

    @Override
    public List<User> findUser(User user) {
        return jdbcTemplate.query("select * from user where id = ?", rowMapper, user.getId());
    }
}
