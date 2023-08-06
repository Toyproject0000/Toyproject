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
import java.util.ArrayList;
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
        String sql = "INSERT INTO post (user_id, contents, title, category, disclosure, date, img_location) VALUES (?, ?, ?, ?, ?, ?,?)";
        jdbcTemplate.update(sql, post.getUserId(), post.getContents(), post.getTitle(), post.getCategory(), post.getDisclosure(), post.getDate(), post.getImgLocation());
    }

    @Override
    public void update(Post post) {
        String sql = "UPDATE post SET user_id = ?, contents = ? WHERE id = ?";
        jdbcTemplate.update(sql, post.getUserId(), post.getContents(), post.getId());
    }
    //이거 다시

    @Override
    public void delete(Post post) {
        jdbcTemplate.update("delete from post where id = ?", post.getId());
    }

    @Override
    public List<Post> findAll() {
        return jdbcTemplate.query("select * from post", rowMapper);
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
    public List<Post> search(Post post, LocalDate formerDate, LocalDate afterDate) {
        List<Object> parameters = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM post WHERE ");

        if (post.getUserId() != null) {
            queryBuilder.append("user_id = ?");
            parameters.add(post.getUserId());
        }

        if (post != null) {
            if (post.getUserId() != null) {
                queryBuilder.append(" AND ");
            }

        if (post.getTitle() != null && !post.getTitle().isEmpty()) {
            queryBuilder.append("title LIKE ?");
            String likePattern = "%" + post.getTitle() + "%";
            parameters.add(likePattern);
        }

        if (post.getContents() != null && !post.getContents().isEmpty()) {
            if (post.getTitle() != null && !post.getTitle().isEmpty()) {
                queryBuilder.append(" AND ");
            }
                queryBuilder.append("contents LIKE ?");
                String likePattern = "%" + post.getContents() + "%";
                parameters.add(likePattern);
        }
        }

    if (formerDate != null) {
        if (post.getUserId() != null || (post != null && (post.getTitle() != null || post.getContents() != null))) {
            queryBuilder.append(" AND ");
        }
        queryBuilder.append("date >= ?");
        parameters.add(formerDate);
    }

    if (afterDate != null) {
        if (post.getUserId() != null || (post != null && (post.getTitle() != null || post.getContents() != null)) || formerDate != null) {
            queryBuilder.append(" AND ");
        }
        queryBuilder.append("date <= ?");
        parameters.add(afterDate);
    }

    String query = queryBuilder.toString();
    Object[] params = parameters.toArray();

    return jdbcTemplate.query(query, params, rowMapper);
}

    @Override
    public List<Post> findPost(Post post) {
        return jdbcTemplate.query("select * from post where id = ?", rowMapper, post.getId());
    }

    @Override
    public List<Post> findByCategory(String category, Integer num) {
        String sql = "SELECT * FROM post WHERE category = ? LIMIT CAST(? AS SIGNED)";
        return jdbcTemplate.query(sql, rowMapper, category, num);
    }
}
