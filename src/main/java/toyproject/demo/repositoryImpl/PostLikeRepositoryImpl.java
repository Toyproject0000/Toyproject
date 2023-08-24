package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.PostLike;
import toyproject.demo.repository.PostLikeRepository;


@Repository
public class PostLikeRepositoryImpl implements PostLikeRepository {
    private final JdbcTemplate jdbcTemplate;

    public PostLikeRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void insert(PostLike postlike) {
        jdbcTemplate.update("insert into post (post_id, user_id) values (?,?)"
                , postlike.getPostId(), postlike.getUserId());
    }

    @Override
    public void delete(PostLike postLike) {
        jdbcTemplate.update("delete from postLike where post_id = ? And user_id = ?", postLike.getPostId(), postLike.getUserId());
    }

}
