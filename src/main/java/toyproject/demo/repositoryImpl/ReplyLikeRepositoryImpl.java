package toyproject.demo.repositoryImpl;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import toyproject.demo.domain.ReplyLike;
import toyproject.demo.repository.ReplyLikeRepository;

@Repository
public class ReplyLikeRepositoryImpl implements ReplyLikeRepository {
    private final JdbcTemplate jdbcTemplate;

    public ReplyLikeRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void insert(ReplyLike replyLike) {
        jdbcTemplate.update("insert into post (post_id, user_id) values (?,?)"
                , replyLike.getReplyId(), replyLike.getUserId());
    }

    @Override
    public void delete(ReplyLike replyLike) {
        jdbcTemplate.update("delete from postLike where post_id = ? And user_id = ?", replyLike.getReplyId(), replyLike.getUserId());
    }
}
