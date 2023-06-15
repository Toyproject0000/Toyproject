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
        jdbcTemplate.update("INSERT INTO users (id, password, name, phoneNumber, nickname, gender) " +
                "VALUES (?, ?, ?, ?, ?, ?)", user.getId(), user.getPassword(), user.getName(), user.getPhoneNumber(), user.getNickname(), user.getGender());
    }

    @Override
    public void update(User user) {
        jdbcTemplate.update("UPDATE users SET password = ?, name = ?, phoneNumber = ?, nickname = ?, gender = ? WHERE id = ?",
                user.getPassword(), user.getName(), user.getPhoneNumber(), user.getNickname(), user.getGender(), user.getId());
    }

    @Override
    public List<User> findAll() {
        return jdbcTemplate.query("select * from user", rowMapper);
    }

    @Override
    public List<User> findByIdAndPassword(String id, String password) {
        return jdbcTemplate.query("select * from user where id = ? and password = ?", rowMapper, id, password);
    }

    @Override
    public List<User> findFollower(String userId) {
        return jdbcTemplate.query("select * from follows where followed_user_id = ?", rowMapper, userId);
    }
    //다시 짜야됨.
}
