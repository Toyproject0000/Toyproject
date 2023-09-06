package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.Category;
import toyproject.demo.domain.Follow;
import toyproject.demo.domain.Post;
import toyproject.demo.repository.CategoryRepository;

import java.util.List;

@Repository
public class CategoryRepositoryImpl implements CategoryRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;

    public CategoryRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(Category.class);
    }


    @Override
    public void plus(Post post, Integer score) {
        String sql = "update category set score = score+? where user_id=? and category=?";
        jdbcTemplate.update(sql, score, post.getUserId(), post.getCategory());
    }

    @Override
    public void plus(Post post, String userId, Integer score) {
        String sql = "update category set score = score+? where user_id=? and category=?";
        jdbcTemplate.update(sql, score, userId, post.getCategory());
    }


    @Override
    public void minus(Post post,String userId ,Integer score) {
        String sql = "update category set score = score-? where user_id=? and category=?";
        jdbcTemplate.update(sql, score, userId, post.getCategory());
    }

    @Override
    public List<Category> findByUser(String userId) {
        String sql = "select * from category where user_id=? ORDER BY score DESC";
        return jdbcTemplate.query(sql, rowMapper, userId);
    }

    /**
     *
     * @param userId
     * @param userRoot
     */

    @Override
    public void insert(String userId, String userRoot) {
        List<String> categories = jdbcTemplate.queryForList("SELECT DISTINCT category FROM post", String.class);

        // SQL 쿼리 템플릿
        String insertSQL = "INSERT INTO category (user_id, category, score, user_root) VALUES (?, ?, 0, ?)";

        for (String category : categories) {
            jdbcTemplate.update(
                    insertSQL,
                    userId,
                    category,
                    userRoot
            );
        }
    }

}
