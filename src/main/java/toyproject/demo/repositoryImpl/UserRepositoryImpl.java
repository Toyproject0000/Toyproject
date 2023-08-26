package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.DTO.ProfileDTO;
import toyproject.demo.domain.User;
import toyproject.demo.repository.UserRepository;

import java.util.List;

@Repository
public class UserRepositoryImpl implements UserRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;
    private final RowMapper profileRowMapper;

    public UserRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.profileRowMapper = BeanPropertyRowMapper.newInstance(ProfileDTO.class);
        this.rowMapper = BeanPropertyRowMapper.newInstance(User.class);
    }

    @Override
    public void insert(User user) {
        jdbcTemplate.update("INSERT INTO user (id, root, password, name, phone_number,  gender, nickname) " +
                "VALUES (?, ? ,?, ?, ?, ?, ?)", user.getId(), user.getRoot(), user.getPassword(), user.getName(), user.getPhoneNumber(), user.getGender(), user.getNickname());
    }

    @Override
    public void update(User user, String userId) {
        jdbcTemplate.update("UPDATE user SET password = COALESCE(?, password),  nickname = COALESCE(?, nickname), info = COALESCE(?, info), img_location = coalesce(?, img_location) WHERE id = ?",
                user.getPassword(), user.getNickname(), user.getInfo(), user.getImgLocation(), userId);
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
    public List<User> findUser(String id) {
        return jdbcTemplate.query("select * from user where id = ?", rowMapper, id);
    }

    @Override
    public List<ProfileDTO> userProfile(String id) {
        return jdbcTemplate.query("select * from user where id = ?", profileRowMapper,id);
    }
}
