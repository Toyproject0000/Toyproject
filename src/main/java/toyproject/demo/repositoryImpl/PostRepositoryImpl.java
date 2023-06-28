package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Reply;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;

import java.time.LocalDate;
import java.util.List;
@Repository

public class PostRepositoryImpl implements PostRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Post> rowMapper;

    public PostRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(Post.class);
    }
    @Override
    public void insert(Post post) {
        String sql = "INSERT INTO post (id, userId, contents) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, post.getId(), post.getUserId(), post.getContents());
    }

    @Override
    public void update(Post post) {
        String sql = "UPDATE post SET userId = ?, contents = ? WHERE id = ?";
        jdbcTemplate.update(sql, post.getUserId(), post.getContents(), post.getId());
    }

    @Override
    public void delete(Post post) {
        jdbcTemplate.update("delete from post where id = ?", post.getId());
    }

    @Override
    public List<Post> findAll() {
        return jdbcTemplate.query("select * from post", rowMapper);
    }

    @Override
    public List<Post> findByUser(User user) {
        return jdbcTemplate.query("select * from post where userId = ?", rowMapper, user.getId());
    }

    @Override
    public List<Post> findByContents(String contents) {
        return jdbcTemplate.query("SELECT * FROM post WHERE contents LIKE ?", rowMapper, "%" + contents + "%");
    }

    @Override
    public List<Post> findMyPostByContents(String contents, User user) {
        return jdbcTemplate.query("SELECT * FROM post WHERE userId = ? And contents LIKE ? ", rowMapper,user.getId(), "%" + contents + "%");
    }

    @Override
    public List<Post> findPostOfFollower(User user) {
        String sql = "SELECT p.* FROM post p INNER JOIN follower f ON p.userId = f.followedUserId WHERE f.followerUserId = ?";
        return jdbcTemplate.query(sql, rowMapper, user.getId());
    }
    @Override
    public List<Post> findAllLikePost(User user) {
        return jdbcTemplate.query("SELECT * FROM post WHERE id IN (SELECT postId FROM postLike WHERE userId = ?)", rowMapper, user.getId());
    }

    @Override
    public List<Post> findPostBySpecificDate(LocalDate date) {
        return jdbcTemplate.query("select * from post where date = ?", rowMapper, date);
    }

    @Override
    public List<Post> findPostAfterSpecificDate(LocalDate date) {
        return jdbcTemplate.query("select * from post where date >= ?", rowMapper, date);
    }
}
