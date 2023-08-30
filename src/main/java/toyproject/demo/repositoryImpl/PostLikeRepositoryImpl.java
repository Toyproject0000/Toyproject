package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.PostLike;
import toyproject.demo.repository.PostLikeRepository;

import java.time.LocalDateTime;


@Repository
public class PostLikeRepositoryImpl implements PostLikeRepository {
    private final JdbcTemplate jdbcTemplate;

    public PostLikeRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void insert(PostLike postlike) {
        jdbcTemplate.update("insert into postLike (post_id, user_id, user_root, date) values (?,?,?)", postlike.getPostId(), postlike.getUserId(), postlike.getUserRoot(), LocalDateTime.now());
    }

    @Override
    public void delete(PostLike postLike) {
        jdbcTemplate.update("delete from postLike where id = ?", postLike.getId());
    }

}
