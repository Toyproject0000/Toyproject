package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import toyproject.demo.domain.PostLike;
import toyproject.demo.repository.PostLikeRepository;


public class PostLikeRepositoryImpl implements PostLikeRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper rowMapper;

    public PostLikeRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.rowMapper = BeanPropertyRowMapper.newInstance(PostLike.class);
    }

    @Override
    public void insert(PostLike postlike) {
        jdbcTemplate.update("insert into post (postId, userId) values (?,?)"
                , postlike.getPostId(), postlike.getUserId());
    }

    @Override
    public void delete(PostLike postLike) {
        jdbcTemplate.update("delete from postLike where postId = ? And userID = ?", postLike.getPostId(), postLike.getUserId());
    }

}
