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
        String sql = "INSERT INTO post (user_id, contents, title, category, disclosure, date, possibly_reply, img_location,  visibly_like, root, user_img) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (select img_location from user u where id = ? and root = ?))";
        jdbcTemplate.update(sql, post.getUserId(), post.getContents(), post.getTitle(), post.getCategory(), post.getDisclosure(), post.getDate(), post.getPossiblyReply(), post.getImgLocation(), post.getVisiblyLike(), post.getRoot(), post.getUserId(), post.getRoot());
    }

    @Override
    public List<Post> findPost(Long id) {
        String sql  = "select * from post where id = ?";
        return jdbcTemplate.query(sql, rowMapper, id);
    }

    @Override
    public void update(Post post) {
        String sql = "update post SET contents = COALESCE(?, contents), title = COALESCE(?, title), category = COALESCE(?, category), disclosure = COALESCE(?, disclosure), possibly_reply = COALESCE(?, possibly_reply), img_location = COALESCE(?, img_location),  visibly_like = COALESCE(?, visibly_like) where id = ?";
        jdbcTemplate.update(sql, post.getContents(), post.getTitle(), post.getCategory(), post.getDisclosure(), post.getPossiblyReply(), post.getImgLocation(), post.getVisiblyLike(), post.getId());
    }

    @Override
    public void delete(Post post) {
        jdbcTemplate.update("delete from post where id = ?", post.getId());
    }

    @Override
    public List<Post> findPostOfFollower(User user) {
        String sql = "SELECT p.*, (SELECT COUNT(*) FROM postLike pl WHERE pl.post_id = p.id) as likeCount FROM post p " +
                "INNER JOIN follow f ON p.user_id = f.followedUserId WHERE f.followedUserId = ? and f.followed_user_root=?";
        return jdbcTemplate.query(sql, rowMapper, user.getId(), user.getRoot());
    }
    @Override
    public List<Post> findAllLikePost(User user) {
        return jdbcTemplate.query("SELECT p.*, (SELECT COUNT(*) FROM postLike pl WHERE pl.post_id = p.id) as likeCount FROM post p WHERE id IN (SELECT post_id FROM postLike WHERE user_id = ?)", rowMapper, user.getId());
    }


    @Override
    public List<Post> search(Post post, LocalDate formerDate, LocalDate afterDate) {
        List<Object> parameters = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT p.*, u.nickname as nickname, " +
                "(SELECT COUNT(*) FROM postLike pl WHERE pl.post_id = p.id) as likeCount " +
                "FROM post p LEFT JOIN user u ON p.user_id = u.id WHERE ");

        if (post.getUserId() != null) {
            queryBuilder.append("p.user_id = ?");
            parameters.add(post.getUserId());
        }

        if (post != null) {
            if (post.getTitle() != null && !post.getTitle().isEmpty()) {
                queryBuilder.append(" AND ");
                queryBuilder.append("p.title LIKE ?");
                String likePattern = "%" + post.getTitle() + "%";
                parameters.add(likePattern);
            }

            if (post.getContents() != null && !post.getContents().isEmpty()) {
                if (post.getTitle() != null && !post.getTitle().isEmpty()) {
                    queryBuilder.append(" AND ");
                }
                queryBuilder.append("p.contents LIKE ?");
                String likePattern = "%" + post.getContents() + "%";
                parameters.add(likePattern);
            }
            if (post.getCategory() != null && !post.getCategory().isEmpty()) {
                if (post.getUserId() != null || post.getTitle() != null || post.getContents() != null){
                    queryBuilder.append(" AND ");
                }
                queryBuilder.append("p.category LIKE ?");
                String likePattern = "%" + post.getCategory() + "%";
                parameters.add(likePattern);
            }
        }

        if (formerDate != null) {
            if (post.getUserId() != null || (post != null && (post.getTitle() != null || post.getContents() != null))) {
                queryBuilder.append(" AND ");
            }
            queryBuilder.append("p.date >= ?");
            parameters.add(formerDate);
        }

        if (afterDate != null) {
            if (post.getUserId() != null || (post != null && (post.getTitle() != null || post.getContents() != null)) || formerDate != null) {
                queryBuilder.append(" AND ");
            }
            queryBuilder.append("p.date <= ?");
            parameters.add(afterDate);
        }

        String query = queryBuilder.toString();
        Object[] params = parameters.toArray();
        List<Post> posts = jdbcTemplate.query(query, params, rowMapper);
        return posts;
    }

    @Override
    public List<Post> findByWriter(String id, String root) {
        String sql = "SELECT p.*, COUNT(pl.post_id) AS likeCount " +
                "FROM post p " +
                "LEFT JOIN postLike pl ON p.id = pl.post_id " +
                "WHERE p.user_id = ? and p.root = ?" +
                "GROUP BY p.id " +
                "ORDER BY p.date DESC";
        return jdbcTemplate.query(sql, rowMapper, id, root);
    }

    @Override
    public List<Post> recommendByAlgorithm(String userId, String userRoot) {
        List<String> categories = jdbcTemplate.queryForList("select category from category where user_id = ? and user_root = ?", String.class, userId, userRoot);
        ArrayList<Post> posts = new ArrayList<>();
        for (String category : categories) {
            posts.addAll(jdbcTemplate.query("SELECT p.*, u.nickname AS nickname,u.root AS Root, COUNT(pl.post_id) AS likeCount FROM post p LEFT JOIN user u ON p.user_id = u.id LEFT JOIN postLike pl ON p.id = pl.post_id WHERE p.category = ? GROUP BY p.id", rowMapper, category));
        }
        return posts;
    }

    @Override
    public List<Post> recommendByCategory(String category) {
        String sql = "SELECT p.*, u.nickname AS nickname, COUNT(pl.post_id) AS likeCount " +
                "FROM post p " +
                "LEFT JOIN user u ON p.user_id = u.id " +
                "LEFT JOIN postLike pl ON p.id = pl.post_id " +
                "WHERE p.category = ? " +
                "GROUP BY p.id";

        return jdbcTemplate.query(sql, rowMapper, category);
    }
}