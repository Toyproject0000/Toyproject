package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Post;
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
        String sql = "INSERT INTO post (user_id, contents, title, category, disclosure, date, possibly_reply, img_location) VALUES (?, ?, ?, ?, ?, ?,?,?)";
        jdbcTemplate.update(sql, post.getUserId(), post.getContents(), post.getTitle(), post.getCategory(), post.getDisclosure(), post.getDate(), post.getPossibleReply(), post.getImgLocation());
    }

    @Override
    public void insertImg(Post post) {
        String updateQuery = "UPDATE post p1" +
                " INNER JOIN (SELECT id FROM post WHERE user_id = ? ORDER BY date DESC LIMIT 1) p2" +
                " ON p1.id = p2.id" +
                " SET p1.img_location = ?";
        jdbcTemplate.update(updateQuery, post.getUserId(), post.getImgLocation());
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
    public List<Post> findPostsByCategory(String userId, int page) {
        String sql = "SELECT p.* " +
                "FROM category c " +
                "LEFT JOIN post p ON c.category = p.category " +
                "WHERE c.user_id = ?";

        Object[] params = {userId, userId, userId};

        return jdbcTemplate.query(sql, rowMapper, userId);
    }

}
